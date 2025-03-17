using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Image : IHelperId
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Path { get; set; }

        public virtual List<int>? ProductImageId { get; set; }
        public virtual List<int>? UserAccountId { get; set; }
    }
}
