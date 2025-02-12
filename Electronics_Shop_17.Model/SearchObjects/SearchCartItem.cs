using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchCartItem : BaseSearch
    {
        public int? Id { get; set; }
        public int? Quantity { get; set; }
        public int? MinQuantity { get; set; }
        public int? ProductId { get; set; }
        public int? ShoppingCartId { get; set; }
    }
}
