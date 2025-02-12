using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoProductImage
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public virtual DtoImage Image { get; set; }
        public virtual DtoProductColor ProductColor { get; set; }
    }
}
