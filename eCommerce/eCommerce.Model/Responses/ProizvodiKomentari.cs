using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class ProizvodiKomentari
    {
        [Key]
        public int Id { get; set; }

        public int ProductId { get; set; }
        public ProductResponse Product { get; set; }
        public DateTime DatumKreiranjaKomentara { get; set; } 
        public string Komentar { get; set; } = string.Empty;

        // Dodajemo za Task 11
        public int UserId { get; set; }
        public string UserFirstName { get; set; } = string.Empty;
        public string UserLastName { get; set; } = string.Empty;
        public int WordCount { get; set; }

    }
}
