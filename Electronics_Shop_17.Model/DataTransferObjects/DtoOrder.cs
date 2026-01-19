using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoOrder
    {
        public int Id { get; set; }
        public DateTime OrderTime { get; set; }
        public double TotalAmount { get; set; }
        public double? FinalTotalAmount { get; set; }
        public string StateMachine { get; set; }

        //public virtual DtoCustomer Customer { get; set; }
        public virtual DtoAdress Adress { get; set; }
        public int? CouponId { get; set; }
        public virtual DtoCoupon Coupon { get; set; }
        public virtual DtoPaymentMethod PaymentMethod { get; set; }
        public virtual List<DtoOrderItem> OrderItems { get; set; }
    }
}
