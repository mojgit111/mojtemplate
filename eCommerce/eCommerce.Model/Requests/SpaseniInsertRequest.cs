using eCommerce.Model.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class SpaseniInsertRequest
    {
        public int ProductId { get; set; }

        public int UserId { get; set; }

        public DateTime DatumSpasavanja { get; set; }


    }
}
