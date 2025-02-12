using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoCustomer
    {
        public int Id { get; set; }
        public int LoyaltyPoints { get; set; }

        public int UserAccountId { get; set; }
        public virtual DtoUserAccount UserAccount { get; set; }
        public virtual List<DtoOrder> Orders { get; set; }
        public virtual List<DtoAdress> Adresses { get; set; }
        public virtual DtoWishlist? Wishlist { get; set; }
        public virtual List<DtoPaymentMethod> PaymentMethods { get; set; }
        public virtual DtoPerson Person { get; set; }
    }
}
