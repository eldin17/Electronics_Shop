﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchDiscount : BaseSearch
    {
        public int? Id { get; set; }
        public string? DiscountType { get; set; }
        public int? Amount { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public bool? IsActive { get; set; }
    }
}
