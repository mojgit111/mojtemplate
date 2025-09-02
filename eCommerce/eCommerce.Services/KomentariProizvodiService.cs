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
    public class KomentariProizvodiService : BaseCRUDService<KomentariProizvodResponse, KomentariProizvodiSearchObject, Database.KomentariProizvod, KomentariProizvodiInsertRequest, KomentariProizvodiUpdateRequest>, IKomentariProizvodiService
    {
        protected readonly BaseProductState _baseProductState;

        public KomentariProizvodiService(eCommerceDbContext context, IMapper mapper, BaseProductState baseProductState) : base(context, mapper)
        {
            _baseProductState = baseProductState;
        }

        protected override async Task BeforeInsert(Database.KomentariProizvod entity, KomentariProizvodiInsertRequest request)
        {
            Console.WriteLine($"DEBUG: BeforeInsert called");
            Console.WriteLine($"DEBUG: Request - ProuductId: {request.ProuductId}, KomentarKorisnika: {request.KomentarKorisnika}, UserId: {request.UserId}");
            Console.WriteLine($"DEBUG: Entity before mapping - ProductId: {entity.ProductId}, KomentarKorisnika: {entity.KomentarKorisnika}, UserId: {entity.UserId}");
            
            // Set current timestamp
            entity.DatumKreiranjaKomentara = DateTime.UtcNow;
            Console.WriteLine($"DEBUG: Set DatumKreiranjaKomentara: {entity.DatumKreiranjaKomentara}");
            
            // Set default UserId if not provided
            if (entity.UserId == 0)
            {
                entity.UserId = 1; // Default to admin user
                Console.WriteLine($"DEBUG: Set default UserId: {entity.UserId}");
            }
            
            Console.WriteLine($"DEBUG: Entity after mapping - ProductId: {entity.ProductId}, KomentarKorisnika: {entity.KomentarKorisnika}, UserId: {entity.UserId}");
            
            await base.BeforeInsert(entity, request);
            Console.WriteLine($"DEBUG: BeforeInsert completed");
        }

        protected override IQueryable<Database.KomentariProizvod> ApplyFilter(IQueryable<Database.KomentariProizvod> query, KomentariProizvodiSearchObject search)
        {

            query=query.Include(x=>x.User).Include(x => x.Product);



            if (search.DateFrom.HasValue)
            {
                query = query.Where(p=> p.DatumKreiranjaKomentara >= search.DateFrom.Value);
            }

            if (search.DateTo.HasValue)
            {
                query = query.Where(p => p.DatumKreiranjaKomentara <= search.DateTo.Value);
            }


            if (search.ProductId.HasValue)
            {
                query = query.Where(p => p.ProductId == search.ProductId.Value);
            }


            return query;
        }
}
}

