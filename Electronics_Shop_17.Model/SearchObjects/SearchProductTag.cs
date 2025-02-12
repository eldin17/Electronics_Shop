using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchProductTag : BaseSearch
    {
        public int? Id { get; set; }
        public string? Tag { get; set; }
    }
}
