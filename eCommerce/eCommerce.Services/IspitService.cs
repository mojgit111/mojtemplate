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
using Microsoft.IdentityModel.Tokens;
namespace eCommerce.Services
{
    public class IspitService : BaseCRUDService<IspitResponse, IspitSearchObject, Database.Ispit30062022, IspitInsertRequest, IspitUpdateRequest>, IIspitiService
    {
        protected readonly BaseProductState _baseProductState;

        public IspitService(eCommerceDbContext context, IMapper mapper, BaseProductState baseProductState) : base(context, mapper)
        {
            _baseProductState = baseProductState;
        }

        protected override IQueryable<Database.Ispit30062022> ApplyFilter(IQueryable<Database.Ispit30062022> query, IspitSearchObject search)
        {

            query = query.Include(x => x.User).ThenInclude(u => u.Orders).Include(x=>x.Product);

            if (!string.IsNullOrEmpty(search.FTS))
            {
                query = query.Where(p => p.User.FirstName.Contains(search.FTS) || p.User.LastName.Contains(search.FTS)
                );
            }
            if ((search.MinimalanIznosNarudzbe.HasValue))
            {
                query = query.Where(p => p.MinimalanIznosNarudzbe>=search.MinimalanIznosNarudzbe);
            }

            if ((search.ProductId.HasValue))
            {
                query = query.Where(p => p.ProductId == search.ProductId);
            }

        
            if (search.DateTo.HasValue)
            {
                query = query.Where(p => p.User.Orders.Any(o => o.OrderDate <= search.DateTo.Value));
            }
            if (search.DateFrom.HasValue)
            {
                query = query.Where(p => p.User.Orders.Any(o => o.OrderDate >= search.DateFrom.Value));
            }

            return query;
        }

      
      
}
}

