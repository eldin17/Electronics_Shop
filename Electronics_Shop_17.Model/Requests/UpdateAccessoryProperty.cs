using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateAccessoryProperty
    {
        public string? PropertyName { get; set; }
        public string? PropertyValue { get; set; }
        public int? AccessoryId { get; set; }
    }
}
