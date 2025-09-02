using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class Spaseni03092025Response
    {
        [Key]
        public int Id { get; set; }

        public int ProductId { get; set; }

        public ProductResponse ProductResponse { get; set; } = null!;

        public int UserId { get; set; }

        public UserResponse User { get; set; } = null!;

        public DateTime DatumSpasavanja { get; set; }

        public string NazivVrsteProizvoda { get; set; } = string.Empty;


        public decimal  IznosUkupneProdaje { get; set; }
    }
}
