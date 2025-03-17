using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoWishlist
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public DateTime DateCreated { get; set; }
        public virtual List<DtoWishlistItem> WishlistItems { get; set; }
    }
}
