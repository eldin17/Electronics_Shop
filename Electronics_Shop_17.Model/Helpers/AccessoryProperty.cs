﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Helpers
{
    public class AccessoryProperty 
    {
        public int Id { get; set; }
        public string PropertyName { get; set; }
        public string PropertyValue { get; set; }

        public int AccessoryId { get; set; }
    }
}
