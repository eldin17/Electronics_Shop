using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchCoupon : BaseSearch
    {
        public int? Id { get; set; }
        public string? Code { get; set; }
        public int? DiscountAmount { get; set; }
        public int? MinPurchaseAmount { get; set; }
        public int? MaxUsagePerCustomer { get; set; }
        public int? ProductCategoryId { get; set; }
        public int? AccessoryCategoryId { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public bool? IsActive { get; set; }

        public bool? isDeleted { get; set; }
    }
}
