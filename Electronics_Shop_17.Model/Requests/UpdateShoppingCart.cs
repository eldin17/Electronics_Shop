﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateShoppingCart
    {
        public virtual List<UpdateCartItem>? CartItems { get; set; }
    }
}
