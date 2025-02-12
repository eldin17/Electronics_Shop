using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchOrder : BaseSearch
    {
        public int? Id { get; set; }
        public DateTime? MinOrderTime { get; set; }
        public DateTime? MaxOrderTime { get; set; }
        public decimal? TotalAmount { get; set; }
        public decimal? MaxTotalAmount { get; set; }
        public decimal? MinTotalAmount { get; set; }

        public int? CustomerId { get; set; }
        public int? AdressId { get; set; }
        public int? CouponId { get; set; }
        public int? PaymentMethodId { get; set; }
    }
}
