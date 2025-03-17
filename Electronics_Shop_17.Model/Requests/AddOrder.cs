using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddOrder
    {
        public DateTime OrderTime { get; set; } = DateTime.UtcNow;
        public double TotalAmount { get; set; }
        public string StateMachine { get; set; } = "Pending";

        public int CustomerId { get; set; }
        public int AdressId { get; set; }
        public int? CouponId { get; set; }
        public int PaymentMethodId { get; set; }
        public virtual List<AddOrderItem> OrderItems { get; set; }
        public string PaymentId { get; set; } = "";
        public string PaymentIntent { get; set; } = "";
    }
}
