﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddOrderItem
    {
        public int Quantity { get; set; }
        public double Price { get; set; }

        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public double FinalPrice { get; set; }
        public int ProductColorId { get; set; }
    }
}
