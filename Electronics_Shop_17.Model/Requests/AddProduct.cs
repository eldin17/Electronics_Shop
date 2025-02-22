using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Helpers;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddProduct
    {
        public string Brand { get; set; }
        public string Model { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public int AllColorsStock { get; set; }

        public int ProductCategoryId { get; set; }
        public virtual List<AddProductProductTag>? ProductProductTags { get; set; }
        public virtual AddWarranty? Warranty { get; set; }


        public virtual AddCamera? Camera { get; set; }
        public virtual AddDesktopPC? DesktopPC { get; set; }
        public virtual AddGamingConsole? GamingConsole { get; set; }
        public virtual AddLaptop? Laptop { get; set; }
        public virtual AddPhone? Phone { get; set; }
        public virtual AddTablet? Tablet { get; set; }
        public virtual AddTelevision? Television { get; set; }

        public virtual AddAccessory? Accessory { get; set; }
        public bool isDeleted { get; set; } = false;

        public string StateMachine { get; set; } = "Initial";
    }
}
