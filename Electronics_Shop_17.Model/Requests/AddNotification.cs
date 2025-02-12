using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddNotification
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public DateTime DateCreated { get; set; } = DateTime.UtcNow;
        public bool IsGeneral { get; set; }
    }
}
