using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoWishlistItem
    {
        public int Id { get; set; }
        public virtual DtoProduct Product { get; set; }
    }
}
