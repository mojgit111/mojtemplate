using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class IspitResponse
    {
        [Key]
        public int Id { get; set; }

        public int UserId { get; set; }

        public UserResponse User { get; set; } = null!;


        public int ProductId { get; set; }
        public ProductResponse Product { get; set; } = null!;

        public decimal MinimalanIznosNarudzbe { get; set; }

        public int BrojNarudzbe { get; set; }

        public decimal IznosNarudzbe { get; set; }
    }
}
