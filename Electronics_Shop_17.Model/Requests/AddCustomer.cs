using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddCustomer
    {
        public int LoyaltyPoints { get; set; } = 0;

        public int UserAccountId { get; set; }
        public virtual List<AddAdress> Adresses { get; set; }
        public virtual List<AddPaymentMethod> PaymentMethods { get; set; }
        public int PersonId { get; set; }
    }
}
