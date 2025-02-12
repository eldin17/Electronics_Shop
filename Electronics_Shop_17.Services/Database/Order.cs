using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Order : IHelperId
    {
        public int Id { get; set; }
        public DateTime OrderTime { get; set; }
        public decimal TotalAmount { get; set; }
        public string StateMachine { get; set; }

        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }
        public int AdressId { get; set; }
        public virtual Adress Adress { get; set; }
        public int? CouponId { get; set; }
        public virtual Coupon Coupon { get; set; }
        public int PaymentMethodId { get; set; }
        public virtual PaymentMethod PaymentMethod { get; set; }
        public virtual List<OrderItem> OrderItems { get; set; }

    }
}
