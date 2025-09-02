using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.Requests
{
    public class KomentariProizvodiUpdateRequest
    {
        public int ProuductId { get; set; }

        public string KomentarKorisnika { get; set; } = string.Empty;


    }
}
