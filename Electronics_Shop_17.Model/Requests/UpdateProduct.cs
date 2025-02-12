using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.Helpers;

namespace Electronics_Shop_17.Model.Requests
{
    public class UpdateProduct
    {
        public string? Brand { get; set; }
        public string? Model { get; set; }
        public string? Description { get; set; }
        public decimal? Price { get; set; }
        public int? AllColorsStock { get; set; }

        public int? ProductCategoryId { get; set; }
        public virtual List<UpdateProductColor>? ProductColors { get; set; }
        public virtual List<UpdateProductProductTag>? ProductProductTags { get; set; }
        public virtual List<UpdateReview>? Reviews { get; set; }
        public virtual UpdateWarranty? Warranty { get; set; }


        public virtual UpdateCamera? Camera { get; set; }
        public virtual UpdateDesktopPC? DesktopPC { get; set; }
        public virtual UpdateGamingConsole? GamingConsole { get; set; }
        public virtual UpdateLaptop? Laptop { get; set; }
        public virtual UpdatePhone? Phone { get; set; }
        public virtual UpdateTablet? Tablet { get; set; }
        public virtual UpdateTelevision? Television { get; set; }

        public virtual UpdateAccessory? Accessory { get; set; }
        public bool? isDeleted { get; set; }

    }
}
