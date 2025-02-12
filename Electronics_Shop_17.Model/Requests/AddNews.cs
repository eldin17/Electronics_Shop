using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddNews
    {
        public string Title { get; set; }
        public string Content { get; set; }
        public DateTime DatePublished { get; set; } = DateTime.UtcNow;
    }
}
