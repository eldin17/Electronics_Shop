using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateNotification
    {
        public string? Title { get; set; }
        public string? Message { get; set; }

        //public virtual List<AddUserNotification>? UserNotifications { get; set; }
    }
}
