using eCommerce.Model.Responses;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class KomentariProizvodiInsertRequest
    {

        public int ProuductId { get; set; }

        public string KomentarKorisnika { get; set; } = string.Empty;

        public int UserId { get; set; }


    }
}
