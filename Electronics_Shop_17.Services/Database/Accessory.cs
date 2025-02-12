using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Accessory : IHelperId
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        public int ProductId { get; set; }
        //public virtual Product Product { get; set; }

        public int AccessoryCategoryId { get; set; }
        public virtual AccessoryCategory AccessoryCategory { get; set; }

        public virtual List<AccessoryProperty> AccessoryProperties { get; set; }
       
    }
}
