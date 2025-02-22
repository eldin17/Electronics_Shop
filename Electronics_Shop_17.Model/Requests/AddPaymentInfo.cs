using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddPaymentInfo
    {
        public string? PaymentId { get; set; }
        public string? PaymentIntent { get; set; }
        public int? OrderId { get; set; }
    }
}
