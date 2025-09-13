using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class CheckAndActivateReq
    {
        public int OrderId { get; set; }
        public int AdressId { get; set; }
        public int PaymentMethodId { get; set; }
    }
}
