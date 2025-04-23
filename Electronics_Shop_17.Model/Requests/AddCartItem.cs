using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddCartItem
    {
        public int Quantity { get; set; }
        public int ProductId { get; set; }
        public int ShoppingCartId { get; set; }
        public int ProductColorId { get; set; }

    }
}
