using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class ProductImage : IHelperId
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int ImageId { get; set; }
        public virtual Image Image { get; set; }
        public int? ProductColorId { get; set; }
        public virtual ProductColor ProductColor { get; set; }
    }
}
