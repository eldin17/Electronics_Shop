﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class ShoppingCart : IHelperId
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public DateTime DateCreated { get; set; }

        public virtual List<CartItem> CartItems { get; set; }
    }
}
