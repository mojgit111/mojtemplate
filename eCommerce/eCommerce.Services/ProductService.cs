using eCommerce.Model;
using eCommerce.Model.SearchObjects;
using eCommerce.Model.Responses;
using eCommerce.Services.Database;
using Microsoft.EntityFrameworkCore;
using eCommerce.Model.Requests;
using MapsterMapper;
using eCommerce.Services.ProductStateMachine;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
namespace eCommerce.Services
{
    public class ProductService : BaseCRUDService<ProductResponse, ProductSearchObject, Database.Product, ProductInsertRequest, ProductUpdateRequest>, IProductService
    {
        protected readonly BaseProductState _baseProductState;

        public ProductService(eCommerceDbContext context, IMapper mapper, BaseProductState baseProductState) : base(context, mapper)
        {
            _baseProductState = baseProductState;
        }

        protected override IQueryable<Database.Product> ApplyFilter(IQueryable<Database.Product> query, ProductSearchObject search)
        {
            if (!string.IsNullOrEmpty(search.FTS))
            {
                query = query.Where(p => p.Name.Contains(search.FTS) || p.Description.Contains(search.FTS)
                );
            }

            if(!string.IsNullOrEmpty(search.Code))
            {
                query = query.Where(p => p.SKU.Contains(search.Code));
            }


            if (search.MaxPrice.HasValue)
            {
                query = query.Where(p => p.Price <= search.MaxPrice.Value);
            }

            query = query.Include(x => x.Assets);

            return query;
        }

        public override async Task<ProductResponse> CreateAsync(ProductInsertRequest request)
        {
            var baseState = _baseProductState.GetProductState("InitialProductState");
            var result = await baseState.CreateAsync(request);

            return result;
            // return base.CreateAsync(request);
        }

        public override async Task<ProductResponse?> UpdateAsync(int id, ProductUpdateRequest request)
        {
            var entity = await _context.Products.FindAsync(id);
            //check if entity is null
            if (entity == null)
            {
                throw new UserException("Product not found");
            }
            var baseState = _baseProductState.GetProductState(entity.ProductState);
            return await baseState.UpdateAsync(id, request);
            // return base.UpdateAsync(id, request);
        }

        public async Task<ProductResponse> ActivateAsync(int id)
        {
            var entity = await _context.Products.FindAsync(id);
            var baseState = _baseProductState.GetProductState(entity.ProductState);

            return await baseState.ActivateAsync(id);
        }

        public async Task<ProductResponse> DeactivateAsync(int id)
        {
            var entity = await _context.Products.FindAsync(id);
            var baseState = _baseProductState.GetProductState(entity.ProductState);

            return await baseState.DeactivateAsync(id);
        }

        public List<string> AllowedActions(int id)
        {
            if (id <= 0)
            {
                var initialBaseState = _baseProductState.GetProductState("InitialProductState");
                return initialBaseState.AllowedActions(id);
            }

            var entity = _context.Products.Find(id);
            if (entity == null)
            {
                throw new UserException("Product not found");
            }
            var baseState = _baseProductState.GetProductState(entity.ProductState);
            return baseState.AllowedActions(id);
        }

        public async Task CreateDummyOrderDataAsync(int userId, int numberOfOrders = 10)
        {
            for (int i = 0; i < numberOfOrders; i++)
            {
                await CreateRandomOrderAsync(userId);
            }
        }

        public async Task<Order> CreateRandomOrderAsync(int userId, int minProducts = 1, int maxProducts = 5)
        {
            // Get all products
            var products = await _context.Products.ToListAsync();
            if (products.Count == 0)
                throw new Exception("No products available to order.");

            var rnd = new Random();
            int numProducts = rnd.Next(minProducts, Math.Min(maxProducts, products.Count) + 1);
            var selectedProducts = products.OrderBy(x => rnd.Next()).Take(numProducts).ToList();

            // Create order
            var order = new Order
            {
                UserId = userId,
                OrderDate = DateTime.UtcNow,
                Status = OrderStatus.Pending,
                TotalAmount = 0, // will be calculated
                OrderItems = new List<OrderItem>(),
                ShippingAddress = "Random Address",
                ShippingCity = "Random City",
                ShippingState = "Random State",
                ShippingZipCode = "00000",
                ShippingCountry = "Random Country"
            };

            decimal total = 0;
            foreach (var product in selectedProducts)
            {
                int quantity = rnd.Next(1, 4); // 1-3 items per product
                decimal unitPrice = product.Price; // assumes Product has Price property
                var orderItem = new OrderItem
                {
                    ProductId = product.Id,
                    Quantity = quantity,
                    UnitPrice = unitPrice,
                    Discount = 0
                };
                total += quantity * unitPrice;
                order.OrderItems.Add(orderItem);
            }
            order.TotalAmount = total;

            _context.Orders.Add(order);
            await _context.SaveChangesAsync();
            return order;
        }


        public List<ProductResponse> Recommend(int id)
        {
            var mlContext = new MLContext();

            var tmpData = _context.Orders
                .Include(o => o.OrderItems).ToList();

            var data = new List<ProductEntry>();

            foreach (var item in tmpData)
            {
                if (item.OrderItems?.Count > 1)
                {
                    var distinctItemId = item.OrderItems
                        .Select(x => x.ProductId)
                        .Distinct()
                        .ToList();

                    distinctItemId.ForEach(y =>
                    {
                        var relatedItems = item.OrderItems.Where(z => z.ProductId != y);
                        foreach (var z in relatedItems)
                        {
                            data.Add(new ProductEntry() { ProductID = (uint)y, CoPurchaseProductID = (uint)z.ProductId });
                        }
                    });
                }
            }

            var trainData = mlContext.Data.LoadFromEnumerable(data);

            var options = new MatrixFactorizationTrainer.Options
            {
                MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID),
                MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID),
                LabelColumnName = nameof(ProductEntry.Label),
                NumberOfIterations = 20,
                ApproximationRank = 100
            };

            var pipeline = mlContext.Recommendation().Trainers.MatrixFactorization(options);
            var model = pipeline.Fit(trainData);

            var relatedProducts = new List<ProductResponse>();
            var products = _context.Products.ToList();
            var predictionEngine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
            foreach (var product in products)
            {
                var prediction = predictionEngine.Predict(new ProductEntry
                {
                    ProductID = (uint)id,
                    CoPurchaseProductID = (uint)product.Id
                });

                if (prediction.Score > 0)
                {
                    relatedProducts.Add(_mapper.Map<ProductResponse>(product));
                }
            }

            return relatedProducts.Take(3).ToList();
        }

        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class ProductEntry
        {
            [KeyType(count: 10)] public uint ProductID { get; set; }
            [KeyType(count: 10)] public uint CoPurchaseProductID { get; set; }
            public float Label { get; set; }
        }
    }
}

