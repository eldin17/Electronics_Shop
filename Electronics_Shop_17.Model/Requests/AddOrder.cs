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
        public decimal TotalAmount { get; set; }
        public string StateMachine { get; set; } = "initial";

        public int CustomerId { get; set; }
        public int AdressId { get; set; }
        public int? CouponId { get; set; }
        public int PaymentMethodId { get; set; }
        public virtual List<AddOrderItem> OrderItems { get; set; }
    }
}
