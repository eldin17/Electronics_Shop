using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoProduct
    {
        public int Id { get; set; }
        public string Brand { get; set; }
        public string Model { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public decimal FinalPrice { get; set; } 
        public int AllColorsStock { get; set; }

        public int ProductCategoryId { get; set; }
        public virtual DtoProductCategory ProductCategory { get; set; }
        public virtual List<DtoProductImage> ProductImages { get; set; }
        public virtual List<DtoProductColor> ProductColors { get; set; }
        public virtual List<DtoProductProductTag> ProductProductTags { get; set; }
        public virtual List<DtoReview> Reviews { get; set; }
        public int? WarrantyId { get; set; }
        public virtual DtoWarranty? Warranty { get; set; }

        public virtual DtoCamera? Camera { get; set; }
        public virtual DtoDesktopPC? DesktopPC { get; set; }
        public virtual DtoGamingConsole? GamingConsole { get; set; }
        public virtual DtoLaptop? Laptop { get; set; }
        public virtual DtoPhone? Phone { get; set; }
        public virtual DtoTablet? Tablet { get; set; }
        public virtual DtoTelevision? Television { get; set; }

        public virtual DtoAccessory? Accessory { get; set; }

        public bool isDeleted { get; set; }

    }
}
