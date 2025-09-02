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
    public class SpaseniService : BaseCRUDService<Spaseni03092025Response, SpaseniSearchObject, Database.Spaseni03092025, SpaseniInsertRequest, SpaseniUpdateRequest>, ISpaseniService
    {
        protected readonly BaseProductState _baseProductState;

        public SpaseniService(eCommerceDbContext context, IMapper mapper, BaseProductState baseProductState) : base(context, mapper)
        {
            _baseProductState = baseProductState;
        }

        protected override IQueryable<Database.Spaseni03092025> ApplyFilter(IQueryable<Database.Spaseni03092025> query, SpaseniSearchObject search)
        {
           

            if (search.ProductId.HasValue)
            {
                query = query.Where(p => p.ProductId <= search.ProductId.Value);
            }


            return query;

        }


    }


}



