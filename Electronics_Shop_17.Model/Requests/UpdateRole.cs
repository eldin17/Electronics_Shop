﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateRole
    {
        public string? RoleName { get; set; }
        public bool? isDeleted { get; set; }
    }
}

