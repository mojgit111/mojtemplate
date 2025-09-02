using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class IspitUpdateRequest
    {


        [Key]
        public int Id { get; set; }
        public int UserId { get; set; }


        public int ProductId { get; set; }

        public decimal MinimalanIznosNarudzbe { get; set; }

        public int BrojNarudzbe { get; set; }

        public decimal IznosNarudzbe { get; set; }
    }
}
