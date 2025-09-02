using eCommerce.Model.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class IspitInsertRequest
    {
        public int UserId { get; set; }



        public int ProductId { get; set; }

        public decimal MinimalanIznosNarudzbe { get; set; }

        public int BrojNarudzbe { get; set; }

        public decimal IznosNarudzbe { get; set; }
    }
}
