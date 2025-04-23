using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoCartItem
    {
        public int Id { get; set; }
        public int Quantity { get; set; }
        public int ProductId { get; set; }
        public virtual DtoProduct Product { get; set; }

        public int ShoppingCartId { get; set; }
        public double FinalPrice { get; set; }

        public int ProductColorId { get; set; }
        public virtual DtoProductColor ProductColor { get; set; }
    }
}
