using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Helpers
{
    public class DtoLogin
    {
        public string Token { get; set; }
        public int UserId { get; set; }
        public string RoleName { get; set; }
    }
}
