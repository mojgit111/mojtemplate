using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class SpaseniUpdateRequest
    {
        public int ProductId { get; set; }

        public int UserId { get; set; }

        public DateTime DatumSpasavanja { get; set; }
    }
}
