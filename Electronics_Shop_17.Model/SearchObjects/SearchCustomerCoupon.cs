using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchCustomerCoupon : BaseSearch
    {
        public int? Id { get; set; }
        public int? CustomerId { get; set; }
        public int? CouponId { get; set; }
        public int? UsageCount { get; set; }
    }
}
