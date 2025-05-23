﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class OrderItem : IHelperId
    {
        public int Id { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }

        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public virtual Product Product { get; set; }
        public double FinalPrice { get; set; }
        public int ProductColorId { get; set; }
        public virtual ProductColor ProductColor { get; set; }
    }
}
