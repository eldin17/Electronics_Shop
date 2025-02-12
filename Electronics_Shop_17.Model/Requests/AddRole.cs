using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddRole
    {
        public string RoleName { get; set; }
        public bool isDeleted { get; set; } = false;

    }
}
