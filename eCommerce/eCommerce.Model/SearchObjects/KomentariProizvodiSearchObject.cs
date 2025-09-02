using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class KomentariProizvodiSearchObject:BaseSearchObject
    {
        public int? ProductId { get; set; }        // ✅ Za oba zadatka
        public DateTime? DateFrom { get; set; }     // ✅ Za mobile
        public DateTime? DateTo { get; set; }

    }
}
