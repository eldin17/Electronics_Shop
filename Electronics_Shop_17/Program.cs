using System.Text;
using Electronics_Shop_17.Services;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.InterfaceImplementations;
using Electronics_Shop_17.Services.Interfaces;
using Electronics_Shop_17.Services.OrderStateMachine;
using Electronics_Shop_17.Services.ProductStateMachine;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IAccessoryPropertyService, AccessoryPropertyService>();
builder.Services.AddTransient<IAccessoryService, AccessoryService>();
builder.Services.AddTransient<ICameraService, CameraService>();
builder.Services.AddTransient<IDesktopPCService, DesktopPCService>();
builder.Services.AddTransient<IGamingConsoleService, GamingConsoleService>();
builder.Services.AddTransient<IImageService, ImageService>();
builder.Services.AddTransient<ILaptopService, LaptopService>();
builder.Services.AddTransient<IPhoneService, PhoneService>();
builder.Services.AddTransient<IProductCategoryService, ProductCategoryService>();
builder.Services.AddTransient<IProductColorService, ProductColorService>();
builder.Services.AddTransient<IProductImageService, ProductImageService>();
builder.Services.AddTransient<IProductService, ProductService>();
builder.Services.AddTransient<ITabletService, TabletService>();
builder.Services.AddTransient<ITelevisionService, TelevisionService>();
builder.Services.AddTransient<IUserAccountService, UserAccountService>();
builder.Services.AddTransient<IProductProductTagService, ProductProductTagService>();
builder.Services.AddTransient<IProductTagService, ProductTagService>();
builder.Services.AddTransient<IReviewService, ReviewService>();
builder.Services.AddTransient<IWarrantyService, WarrantyService>();
builder.Services.AddTransient<IRoleService, RoleService>();
builder.Services.AddTransient<IShoppingCartService, ShoppingCartService>();
builder.Services.AddTransient<ICartItemService, CartItemService>();
builder.Services.AddTransient<IWishlistItemService, WishlistItemService>();
builder.Services.AddTransient<IWishlistService, WishlistService>();
builder.Services.AddTransient<INotificationService, NotificationService>();
builder.Services.AddTransient<IUserNotificationService, UserNotificationService>();
builder.Services.AddTransient<IOrderItemService, OrderItemService>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<IPaymentMethodService, PaymentMethodService>();
builder.Services.AddTransient<ICouponService, CouponService>();
builder.Services.AddTransient<INewsService, NewsService>();
builder.Services.AddTransient<IProductDiscountService, ProductDiscountService>();
builder.Services.AddTransient<IDiscountService, DiscountService>();
builder.Services.AddTransient<ICustomerService, CustomerService>();
builder.Services.AddTransient<ISellerService, SellerService>();
builder.Services.AddTransient<IAdressService, AdressService>();
builder.Services.AddTransient<IPersonService, PersonService>();
builder.Services.AddTransient<ICustomerCouponService, CustomerCouponService>();
builder.Services.AddTransient<IAccessoryCategoryService, AccessoryCategoryService>();


builder.Services.AddTransient<BaseProductState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();
builder.Services.AddTransient<OutOfStockProductState>();
builder.Services.AddTransient<ArchivedProductState>();


builder.Services.AddTransient<BaseOrderState>();
builder.Services.AddTransient<DraftOrderState>();
builder.Services.AddTransient<PendingOrderState>();
builder.Services.AddTransient<CompletedOrderState>();
builder.Services.AddTransient<DeletedOrderState>();

builder.Services.AddTransient<Checks>();


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
    {
        Description = "Swagger Authorization Header -> (\"Bearer {token}\")",
        In = ParameterLocation.Header,
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey
    });
    options.OperationFilter<SecurityRequirementsOperationFilter>();
});

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(
                    builder.Configuration.GetSection("AppSettings:Token").Value)),
            ValidateIssuer = false,
            ValidateAudience = false
        };
    });


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<DataContext>(options =>
    options.UseLazyLoadingProxies()
           .UseSqlServer(connectionString));



builder.Services.AddAutoMapper(typeof(IAccessoryService));


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseStaticFiles();


app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<DataContext>();

    dataContext.Database.Migrate();
}

app.Run();
