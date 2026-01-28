using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Services.Database;

namespace Electronics_Shop_17.Services.Helpers
{
    public class OrderValidationResult
    {
        public bool HasChanges { get; set; }
        public double TotalAmount { get; set; }
        public double FinalTotalAmount { get; set; }
        public List<OrderItem> CorrectedItems { get; set; } = new();
    }
}
