﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateProductColor
    {
        public string? Name { get; set; }
        public string? HexCode { get; set; }
        public int? Stock { get; set; }
    }
}
