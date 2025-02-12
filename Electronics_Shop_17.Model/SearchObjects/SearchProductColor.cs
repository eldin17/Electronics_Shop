using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchProductColor : BaseSearch
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        public string? HexCode { get; set; }
        public int? Stock { get; set; }
    }
}
