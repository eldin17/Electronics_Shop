﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateCartItem
    {
        public int? Id { get; set; }
        public int? Quantity { get; set; }
        public int? ProductId { get; set; }

    }
}
