using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddPaymentMethod
    {
        public string Type { get; set; }
        public string Provider { get; set; }
        public string? Key { get; set; }
        public DateTime ExpiryDate { get; set; }
        public bool IsDefault { get; set; }
        public int CustomerId { get; set; }
        public bool isDeleted { get; set; } = false;
    }
}
