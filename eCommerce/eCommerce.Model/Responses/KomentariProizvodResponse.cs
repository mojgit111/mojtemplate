using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Responses
{
    public class KomentariProizvodResponse
    {
        [Key]
        public int Id { get; set; }

        public int ProductId { get; set; }

        [ForeignKey("ProductId")]
        public ProductResponse Product { get; set; } = null!;

        public DateTime DatumKreiranjaKomentara { get; set; }

        public string KomentarKorisnika { get; set; }

        public int UserId { get; set; }

        [ForeignKey("UserId")]
        public UserResponse User { get; set; } = null!;
    }
}
