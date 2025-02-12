using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Warranty : IHelperId
    {
        public int Id { get; set; }
        public int Period_mm { get; set; }
        public string CoverageDetails { get; set; }
        public int ProductId { get; set; }
        //public virtual Product Product { get; set; }

    }
}
