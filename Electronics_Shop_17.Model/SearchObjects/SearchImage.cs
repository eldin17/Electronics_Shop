using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchImage : BaseSearch
    {
        public int? Id { get; set; }
        public string? Name { get; set; }

        public int? ProductImageId { get; set; }
        public int? UserAccountId { get; set; }
    }
}
