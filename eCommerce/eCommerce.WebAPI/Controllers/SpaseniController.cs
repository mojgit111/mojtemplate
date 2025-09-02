using eCommerce.Model;
using eCommerce.Model.SearchObjects;
using eCommerce.Model.Responses;
using eCommerce.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using eCommerce.Model.Requests;
using Microsoft.AspNetCore.Authorization;

namespace eCommerce.WebAPI.Controllers
{

    public class SpaseniController : BaseCRUDController<Spaseni03092025Response, SpaseniSearchObject, SpaseniInsertRequest, SpaseniUpdateRequest>
    {
        ISpaseniService _spaseniService;
        public SpaseniController(ISpaseniService service) : base(service)
        {
            _spaseniService = service;
        }

       
    }
}
