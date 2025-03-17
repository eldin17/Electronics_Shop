using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Product : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string Brand { get; set; }
        public string Model { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        //public int AllColorsStock { get; set; }

        public int ProductCategoryId { get; set; }
        public virtual ProductCategory ProductCategory { get; set; }
        public virtual List<ProductImage> ProductImages { get; set; }
        public virtual List<ProductColor> ProductColors { get; set; }
        public virtual List<ProductProductTag> ProductProductTags { get; set; }
        public virtual List<Review> Reviews { get; set; }
        public virtual Warranty? Warranty { get; set; }
        public virtual List<ProductDiscount> ProductDiscounts { get; set; }


        public virtual Camera? Camera { get; set; }
        public virtual DesktopPC? DesktopPC { get; set; }
        public virtual GamingConsole? GamingConsole { get; set; }
        public virtual Laptop? Laptop { get; set; }
        public virtual Phone? Phone { get; set; }
        public virtual Tablet? Tablet { get; set; }
        public virtual Television? Television { get; set; }

        public virtual Accessory? Accessory { get; set; }
        public bool isDeleted { get; set; }
        public string StateMachine { get; set; }

    }
}
