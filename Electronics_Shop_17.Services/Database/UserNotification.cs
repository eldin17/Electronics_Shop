using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class UserNotification : IHelperId
    {
        public int Id { get; set; }
        public int UserAccountId { get; set; }
        public int NotificationId { get; set; }
        public bool IsRead { get; set; }

    }
}
