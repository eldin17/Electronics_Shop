﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public interface ISoftDelete
    {
        public bool isDeleted { get; set; }
    }
}
