using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class ProductProductTag : IHelperId
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int ProductTagId { get; set; }
        public virtual ProductTag ProductTag { get; set; }
    }
}
