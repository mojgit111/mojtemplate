using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.InteropServices;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class ProizvodKomentariInsertRequest
    {
        [Required]
        public int ProductId { get; set; }
        public DateTime DatumKreiranjaKomentara{ get; set; }=DateTime.UtcNow;

        [Required]
        [MaxLength(1000)]
        public string Komentar { get; set; } = string.Empty;
    }
}
