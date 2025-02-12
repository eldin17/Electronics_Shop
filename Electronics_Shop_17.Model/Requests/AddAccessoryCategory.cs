using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Helpers;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddAccessoryCategory
    {
        public string Name { get; set; }
        
        public bool isDeleted { get; set; } = false;

    }
}
