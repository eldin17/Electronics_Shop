using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Requests;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchProduct : BaseSearch
    {
        public int? Id { get; set; }
        public string? FullTextSearch { get; set; }
        public string? FullTextCategorySearch { get; set; }
        public string? Brand { get; set; }
        public string? Model { get; set; }
        public string? Description { get; set; }
        public double? PriceLow { get; set; }
        public double? PriceHigh { get; set; }
        public int? AllColorsStock { get; set; }

        public int? ProductCategoryId { get; set; }
        public virtual List<int>? ProductProductTags { get; set; }
        public bool? isDeleted { get; set; }

    }
}
