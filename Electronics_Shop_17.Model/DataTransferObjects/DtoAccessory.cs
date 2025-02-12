using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoAccessory
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int ProductId { get; set; }

        public virtual DtoAccessoryCategory AccessoryCategory { get; set; }

        public virtual List<DtoAccessoryProperty> AccessoryProperties { get; set; }

    }
}
