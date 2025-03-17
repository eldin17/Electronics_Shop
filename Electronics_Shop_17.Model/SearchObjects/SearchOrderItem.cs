using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchOrderItem : BaseSearch
    {
        public int? Id { get; set; }
        public int? Quantity { get; set; }
        public double? Price { get; set; }
        public double? FinalPrice { get; set; }

        public int? OrderId { get; set; }
    }
}
