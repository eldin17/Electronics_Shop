using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class PaymentMethod : IHelperId
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Type { get; set; }
        public string Provider { get; set; }
        
    }
}
