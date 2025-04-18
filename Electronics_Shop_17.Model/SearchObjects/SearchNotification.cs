﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchNotification : BaseSearch
    {
        public int? Id { get; set; }
        public string? Title { get; set; }
        public string? Message { get; set; }
        public DateTime? DateCreated { get; set; }
        public bool? IsGeneral { get; set; }
    }
}
