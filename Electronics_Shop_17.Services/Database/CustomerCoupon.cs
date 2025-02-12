using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class CustomerCoupon : IHelperId
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public int CouponId { get; set; }
        public int UsageCount { get; set; }

        //public virtual Customer Customer { get; set; }
        //public virtual Coupon Coupon { get; set; }
    }
}
