using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;

namespace Electronics_Shop_17.Services.Helpers
{
    public class StripeCheckoutResponse
    {
        public bool RequiresOrderUpdate { get; set; }
        public DtoOrderSuggestion? OrderSuggestion { get; set; }

        public string? SessionId { get; set; }
        public string? CheckoutUrl { get; set; }
    }
}
