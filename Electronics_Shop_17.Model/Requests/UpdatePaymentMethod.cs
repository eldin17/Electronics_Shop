using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdatePaymentMethod
    {        
        public string? Code { get; set; }
        public string? Type { get; set; }
        public string? Provider { get; set; }
        
    }
}
