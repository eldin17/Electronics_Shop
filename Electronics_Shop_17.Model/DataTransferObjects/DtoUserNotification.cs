﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoUserNotification
    {
        public int Id { get; set; }
        public int UserAccountId { get; set; }
        public int NotificationId { get; set; }
        public bool IsRead { get; set; }
    }
}
