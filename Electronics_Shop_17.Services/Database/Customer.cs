using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Customer : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public int LoyaltyPoints { get; set; }

        public int UserAccountId { get; set; }
        public virtual UserAccount UserAccount { get; set; }
        //public virtual List<Order> Orders { get; set; }
        public virtual List<Adress> Adresses { get; set; }
        public virtual Wishlist? Wishlist { get; set; }
        public virtual List<PaymentMethod> PaymentMethods { get; set; }
        public int PersonId { get; set; }
        public virtual Person Person { get; set; }
        public bool isDeleted { get; set; }
    }
}
