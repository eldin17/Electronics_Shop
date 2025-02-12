using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateProductCategory
    {

        public string? Name { get; set; }
        public bool? isDeleted { get; set; }
    }
}
