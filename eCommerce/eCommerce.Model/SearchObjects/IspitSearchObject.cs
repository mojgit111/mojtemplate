using System;
using System.Collections.Generic;
using System.Text;

namespace eCommerce.Model.SearchObjects
{
    public class IspitSearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }

        public int? ProductId { get; set; }

        public decimal? MinimalanIznosNarudzbe { get; set; }

        public DateTime? DateFrom { get; set; }
        public DateTime? DateTo { get; set; }
    }
}
