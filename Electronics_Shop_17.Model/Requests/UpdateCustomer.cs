using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateCustomer
    {
        public int? LoyaltyPoints { get; set; }

        public virtual List<UpdateAdress>? Adresses { get; set; }
        public virtual List<UpdatePaymentMethod>? PaymentMethods { get; set; }
        public bool? isDeleted { get; set; }
        public virtual UpdatePerson Person { get; set; }
    }
}
