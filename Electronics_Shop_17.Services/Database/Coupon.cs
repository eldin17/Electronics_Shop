using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Coupon : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public int DiscountAmount { get; set; }
        public int MinPurchaseAmount { get; set; }
        public int MaxUsagePerCustomer { get; set; }
        public int? ProductCategoryId { get; set; }//nepotrebno
        public int? AccessoryCategoryId { get; set; }//nepotrebno
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public bool IsActive { get; set; }

        //public virtual List<Order> Orders { get; set; }
        public bool isDeleted { get; set; }

    }
}
