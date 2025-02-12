using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class PaymentMethod : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Provider { get; set; }
        public string? Key { get; set; }
        public DateTime ExpiryDate { get; set; }
        public bool IsDefault { get; set; }
        public int CustomerId { get; set; }
        public virtual Customer Customer { get; set; }
        public virtual List<Order> Orders { get; set; }
        public bool isDeleted { get; set; }
    }
}
