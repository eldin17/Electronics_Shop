using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class ProductColor : IHelperId
    {
        public int Id { get; set; }
        public virtual List<ProductImage> ProductImages { get; set; }
        public string Name { get; set; }
        public string HexCode { get; set; }
        public int Stock { get; set; }
    }
}
