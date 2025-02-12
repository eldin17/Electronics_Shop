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
        public decimal TotalAmount { get; set; }

        public virtual DtoCustomer Customer { get; set; }
        public virtual DtoAdress Adress { get; set; }
        public virtual DtoCoupon Coupon { get; set; }
        public virtual DtoPaymentMethod PaymentMethod { get; set; }
        public virtual List<DtoOrderItem> OrderItems { get; set; }
    }
}
