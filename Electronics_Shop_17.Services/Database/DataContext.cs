using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class DataContext : DbContext
    {
        public DataContext()
        {
        }
        public DataContext(DbContextOptions options) : base(options)
        {
        }

        public virtual DbSet<Accessory> Accessories { get; set; }
        public virtual DbSet<AccessoryCategory> AccessoryCategories { get; set; }
        public virtual DbSet<AccessoryProperty> AccessoryProperties { get; set; }
        public virtual DbSet<Adress> Addresses { get; set; }
        public virtual DbSet<Camera> Cameras { get; set; }
        public virtual DbSet<CartItem> CartItems { get; set; }
        public virtual DbSet<Coupon> Coupons { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<CustomerCoupon> CustomerCoupons { get; set; }
        public virtual DbSet<DesktopPC> DesktopPCs { get; set; }
        public virtual DbSet<Discount> Discounts { get; set; }
        public virtual DbSet<GamingConsole> GamingConsoles { get; set; }
        public virtual DbSet<Image> Images { get; set; }
        public virtual DbSet<Laptop> Laptops { get; set; }
        public virtual DbSet<News> News { get; set; }
        public virtual DbSet<Notification> Notifications { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderItem> OrderItems { get; set; }
        public virtual DbSet<PaymentMethod> PaymentMethods { get; set; }
        public virtual DbSet<Person> People { get; set; }
        public virtual DbSet<Phone> Phones { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductCategory> ProductCategories { get; set; }
        public virtual DbSet<ProductColor> ProductColors { get; set; }
        public virtual DbSet<ProductDiscount> ProductDiscounts { get; set; }
        public virtual DbSet<ProductImage> ProductImages { get; set; }
        public virtual DbSet<ProductProductTag> ProductProductTags { get; set; }
        public virtual DbSet<ProductTag> ProductTags { get; set; }
        public virtual DbSet<Review> Reviews { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<Seller> Sellers { get; set; }
        public virtual DbSet<ShoppingCart> ShoppingCarts { get; set; }
        public virtual DbSet<Tablet> Tablets { get; set; }
        public virtual DbSet<Television> Televisions { get; set; }
        public virtual DbSet<UserAccount> UserAccounts { get; set; }
        public virtual DbSet<UserNotification> UserNotifications { get; set; }
        public virtual DbSet<Warranty> Warranties { get; set; }
        public virtual DbSet<Wishlist> Wishlists { get; set; }
        public virtual DbSet<WishlistItem> WishlistItems { get; set; }

    }
}
