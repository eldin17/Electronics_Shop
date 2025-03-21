﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Helpers
{
    public class Pagination<T>
    {
        public List<T> Data { get; set; }
        public int? TotalItems { get; set; }

        public Pagination(List<T> data, int? totalItems)
        {
            Data = data;
            TotalItems = totalItems;
        }
    }
}
