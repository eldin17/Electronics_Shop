using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Helpers
{
    public class ResetPW
    {
        public int UserAccId { get; set; } 
        public String OldPassword { get; set; }
        public String NewPassword { get; set; }
    }
}
