using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;

namespace Electronics_Shop_17.Services
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Accessory, DtoAccessory>().ReverseMap();
            CreateMap<Accessory, AddAccessory>().ReverseMap();
            CreateMap<Accessory, UpdateAccessory>().ReverseMap()
            .ForMember(dest => dest.Name, opt => opt.Condition(src => src.Name != null))
            .ForMember(dest => dest.Description, opt => opt.Condition(src => src.Description != null))
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId.HasValue))
            .ForMember(dest => dest.AccessoryCategoryId, opt => opt.Condition(src => src.AccessoryCategoryId.HasValue))
            .ForMember(dest => dest.AccessoryProperties, opt => opt.Condition(src => src.AccessoryProperties != null)); ;


            CreateMap<Electronics_Shop_17.Services.Database.AccessoryProperty, DtoAccessoryProperty>().ReverseMap();
            CreateMap<Electronics_Shop_17.Model.Helpers.AccessoryProperty, DtoAccessoryProperty>().ReverseMap();

            CreateMap<Electronics_Shop_17.Services.Database.AccessoryProperty, AddAccessoryProperty>().ReverseMap();
            CreateMap<Electronics_Shop_17.Model.Helpers.AccessoryProperty, AddAccessoryProperty>().ReverseMap();

            CreateMap<Electronics_Shop_17.Services.Database.AccessoryProperty, UpdateAccessoryProperty>().ReverseMap()
            .ForMember(dest => dest.PropertyName, opt => opt.Condition(src => src.PropertyName != null))
            .ForMember(dest => dest.PropertyValue, opt => opt.Condition(src => src.PropertyValue != null))
            .ForMember(dest => dest.AccessoryId, opt => opt.Condition(src => src.AccessoryId != null));
            CreateMap<Electronics_Shop_17.Model.Helpers.AccessoryProperty, UpdateAccessoryProperty>().ReverseMap()
            .ForMember(dest => dest.PropertyName, opt => opt.Condition(src => src.PropertyName != null))
            .ForMember(dest => dest.PropertyValue, opt => opt.Condition(src => src.PropertyValue != null))
            .ForMember(dest => dest.AccessoryId, opt => opt.Condition(src => src.AccessoryId != null)); 

            CreateMap<Electronics_Shop_17.Services.Database.AccessoryProperty, Electronics_Shop_17.Model.Helpers.AccessoryProperty>().ReverseMap();


            CreateMap<AccessoryCategory, DtoAccessoryCategory>().ReverseMap();
            CreateMap<AccessoryCategory, AddAccessoryCategory>().ReverseMap();
            CreateMap<AccessoryCategory, UpdateAccessoryCategory>().ReverseMap()
            .ForMember(dest => dest.Name, opt => opt.Condition(src => src.Name != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));

            CreateMap<Camera, DtoCamera>().ReverseMap();
            CreateMap<Camera, AddCamera>().ReverseMap();
            CreateMap<Camera, UpdateCamera>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.Megapixels, opt => opt.Condition(src => src.Megapixels != null))
            .ForMember(dest => dest.SensorType, opt => opt.Condition(src => src.SensorType != null))
            .ForMember(dest => dest.LensMount, opt => opt.Condition(src => src.LensMount != null))
            .ForMember(dest => dest.VideoResolution, opt => opt.Condition(src => src.VideoResolution != null))
            .ForMember(dest => dest.Weight, opt => opt.Condition(src => src.Weight != null))
            .ForMember(dest => dest.Dimensions, opt => opt.Condition(src => src.Dimensions != null))
            .ForMember(dest => dest.HasWiFi, opt => opt.Condition(src => src.HasWiFi != null))
            .ForMember(dest => dest.HasBluetooth, opt => opt.Condition(src => src.HasBluetooth != null))
            .ForMember(dest => dest.BatteryType, opt => opt.Condition(src => src.BatteryType != null))
            .ForMember(dest => dest.BatteryLife, opt => opt.Condition(src => src.BatteryLife != null));

            CreateMap<DesktopPC, DtoDesktopPC>().ReverseMap();
            CreateMap<DesktopPC, AddDesktopPC>().ReverseMap();
            CreateMap<DesktopPC, UpdateDesktopPC>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.Processor, opt => opt.Condition(src => src.Processor != null))
            .ForMember(dest => dest.Ram, opt => opt.Condition(src => src.Ram != null))
            .ForMember(dest => dest.StorageType, opt => opt.Condition(src => src.StorageType != null))
            .ForMember(dest => dest.StorageCapacity, opt => opt.Condition(src => src.StorageCapacity != null))
            .ForMember(dest => dest.GraphicsCard, opt => opt.Condition(src => src.GraphicsCard != null))
            .ForMember(dest => dest.OperatingSystem, opt => opt.Condition(src => src.OperatingSystem != null))
            .ForMember(dest => dest.FormFactor, opt => opt.Condition(src => src.FormFactor != null))
            .ForMember(dest => dest.Weight, opt => opt.Condition(src => src.Weight != null))
            .ForMember(dest => dest.Dimensions, opt => opt.Condition(src => src.Dimensions != null))
            .ForMember(dest => dest.UsbPorts, opt => opt.Condition(src => src.UsbPorts != null))
            .ForMember(dest => dest.HasWiFi, opt => opt.Condition(src => src.HasWiFi != null))
            .ForMember(dest => dest.HasBluetooth, opt => opt.Condition(src => src.HasBluetooth != null))
            .ForMember(dest => dest.PowerSupplyWattage, opt => opt.Condition(src => src.PowerSupplyWattage != null))
            .ForMember(dest => dest.CoolingType, opt => opt.Condition(src => src.CoolingType != null))
            .ForMember(dest => dest.HasRGBLighting, opt => opt.Condition(src => src.HasRGBLighting != null));


            CreateMap<GamingConsole, DtoGamingConsole>().ReverseMap();
            CreateMap<GamingConsole, AddGamingConsole>().ReverseMap();
            CreateMap<GamingConsole, UpdateGamingConsole>().ReverseMap();

            CreateMap<Laptop, DtoLaptop>().ReverseMap();
            CreateMap<Laptop, AddLaptop>().ReverseMap();
            CreateMap<Laptop, UpdateLaptop>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.Processor, opt => opt.Condition(src => src.Processor != null))
            .ForMember(dest => dest.Ram, opt => opt.Condition(src => src.Ram != null))
            .ForMember(dest => dest.StorageType, opt => opt.Condition(src => src.StorageType != null))
            .ForMember(dest => dest.StorageCapacity, opt => opt.Condition(src => src.StorageCapacity != null))
            .ForMember(dest => dest.GraphicsCard, opt => opt.Condition(src => src.GraphicsCard != null))
            .ForMember(dest => dest.ScreenSize, opt => opt.Condition(src => src.ScreenSize != null))
            .ForMember(dest => dest.ScreenResolution, opt => opt.Condition(src => src.ScreenResolution != null))
            .ForMember(dest => dest.ScreenType, opt => opt.Condition(src => src.ScreenType != null))
            .ForMember(dest => dest.BatteryCapacity, opt => opt.Condition(src => src.BatteryCapacity != null))
            .ForMember(dest => dest.BatteryLife, opt => opt.Condition(src => src.BatteryLife != null))
            .ForMember(dest => dest.HasWiFi, opt => opt.Condition(src => src.HasWiFi != null))
            .ForMember(dest => dest.HasBluetooth, opt => opt.Condition(src => src.HasBluetooth != null))
            .ForMember(dest => dest.UsbPorts, opt => opt.Condition(src => src.UsbPorts != null))
            .ForMember(dest => dest.HasEthernetPort, opt => opt.Condition(src => src.HasEthernetPort != null))
            .ForMember(dest => dest.HasHDMI, opt => opt.Condition(src => src.HasHDMI != null))
            .ForMember(dest => dest.HasThunderbolt, opt => opt.Condition(src => src.HasThunderbolt != null))
            .ForMember(dest => dest.Weight, opt => opt.Condition(src => src.Weight != null))
            .ForMember(dest => dest.Dimensions, opt => opt.Condition(src => src.Dimensions != null))
            .ForMember(dest => dest.BuildMaterial, opt => opt.Condition(src => src.BuildMaterial != null))
            .ForMember(dest => dest.HasBacklitKeyboard, opt => opt.Condition(src => src.HasBacklitKeyboard != null))
            .ForMember(dest => dest.HasFingerprintReader, opt => opt.Condition(src => src.HasFingerprintReader != null))
            .ForMember(dest => dest.HasWebcam, opt => opt.Condition(src => src.HasWebcam != null))
            .ForMember(dest => dest.OperatingSystem, opt => opt.Condition(src => src.OperatingSystem != null));


            CreateMap<Phone, DtoPhone>().ReverseMap();
            CreateMap<Phone, AddPhone>().ReverseMap();
            CreateMap<Phone, UpdatePhone>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.ScreenSize, opt => opt.Condition(src => src.ScreenSize != null))
            .ForMember(dest => dest.ScreenResolution, opt => opt.Condition(src => src.ScreenResolution != null))
            .ForMember(dest => dest.ScreenType, opt => opt.Condition(src => src.ScreenType != null))
            .ForMember(dest => dest.RefreshRate, opt => opt.Condition(src => src.RefreshRate != null))            
            .ForMember(dest => dest.Processor, opt => opt.Condition(src => src.Processor != null))
            .ForMember(dest => dest.Ram, opt => opt.Condition(src => src.Ram != null))
            .ForMember(dest => dest.StorageCapacity, opt => opt.Condition(src => src.StorageCapacity != null))
            .ForMember(dest => dest.SupportsExpandableStorage, opt => opt.Condition(src => src.SupportsExpandableStorage != null))            
            .ForMember(dest => dest.RearCamerasCount, opt => opt.Condition(src => src.RearCamerasCount != null))
            .ForMember(dest => dest.HasUltrawideLens, opt => opt.Condition(src => src.HasUltrawideLens != null))
            .ForMember(dest => dest.HasZoomLens, opt => opt.Condition(src => src.HasZoomLens != null))
            .ForMember(dest => dest.MainCameraResolution, opt => opt.Condition(src => src.MainCameraResolution != null))
            .ForMember(dest => dest.FrontCameraResolution, opt => opt.Condition(src => src.FrontCameraResolution != null))            
            .ForMember(dest => dest.BatteryCapacity, opt => opt.Condition(src => src.BatteryCapacity != null))
            .ForMember(dest => dest.SupportsFastCharging, opt => opt.Condition(src => src.SupportsFastCharging != null))
            .ForMember(dest => dest.SupportsWirelessCharging, opt => opt.Condition(src => src.SupportsWirelessCharging != null))
            .ForMember(dest => dest.EstimatedBatteryLife, opt => opt.Condition(src => src.EstimatedBatteryLife != null))            
            .ForMember(dest => dest.Supports5G, opt => opt.Condition(src => src.Supports5G != null))
            .ForMember(dest => dest.HasWiFi6, opt => opt.Condition(src => src.HasWiFi6 != null))
            .ForMember(dest => dest.HasBluetooth, opt => opt.Condition(src => src.HasBluetooth != null))
            .ForMember(dest => dest.HasNFC, opt => opt.Condition(src => src.HasNFC != null))
            .ForMember(dest => dest.HasDualSIM, opt => opt.Condition(src => src.HasDualSIM != null))            
            .ForMember(dest => dest.Weight, opt => opt.Condition(src => src.Weight != null))
            .ForMember(dest => dest.Dimensions, opt => opt.Condition(src => src.Dimensions != null))
            .ForMember(dest => dest.BuildMaterial, opt => opt.Condition(src => src.BuildMaterial != null))            
            .ForMember(dest => dest.OperatingSystem, opt => opt.Condition(src => src.OperatingSystem != null))
            .ForMember(dest => dest.HasFingerprintSensor, opt => opt.Condition(src => src.HasFingerprintSensor != null))
            .ForMember(dest => dest.HasFaceRecognition, opt => opt.Condition(src => src.HasFaceRecognition != null))
            .ForMember(dest => dest.IsWaterResistant, opt => opt.Condition(src => src.IsWaterResistant != null));


            CreateMap<Tablet, DtoTablet>().ReverseMap();
            CreateMap<Tablet, AddTablet>().ReverseMap();
            CreateMap<Tablet, UpdateTablet>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.ScreenSize, opt => opt.Condition(src => src.ScreenSize != null))
            .ForMember(dest => dest.ScreenResolution, opt => opt.Condition(src => src.ScreenResolution != null))
            .ForMember(dest => dest.ScreenType, opt => opt.Condition(src => src.ScreenType != null))
            .ForMember(dest => dest.RefreshRate, opt => opt.Condition(src => src.RefreshRate != null))            
            .ForMember(dest => dest.Processor, opt => opt.Condition(src => src.Processor != null))
            .ForMember(dest => dest.Ram, opt => opt.Condition(src => src.Ram != null))
            .ForMember(dest => dest.StorageCapacity, opt => opt.Condition(src => src.StorageCapacity != null))
            .ForMember(dest => dest.SupportsExpandableStorage, opt => opt.Condition(src => src.SupportsExpandableStorage != null))            
            .ForMember(dest => dest.RearCameraResolution, opt => opt.Condition(src => src.RearCameraResolution != null))
            .ForMember(dest => dest.FrontCameraResolution, opt => opt.Condition(src => src.FrontCameraResolution != null))            
            .ForMember(dest => dest.BatteryCapacity, opt => opt.Condition(src => src.BatteryCapacity != null))
            .ForMember(dest => dest.EstimatedBatteryLife, opt => opt.Condition(src => src.EstimatedBatteryLife != null))
            .ForMember(dest => dest.SupportsFastCharging, opt => opt.Condition(src => src.SupportsFastCharging != null))
            .ForMember(dest => dest.SupportsWirelessCharging, opt => opt.Condition(src => src.SupportsWirelessCharging != null))            
            .ForMember(dest => dest.Supports5G, opt => opt.Condition(src => src.Supports5G != null))
            .ForMember(dest => dest.HasWiFi6, opt => opt.Condition(src => src.HasWiFi6 != null))
            .ForMember(dest => dest.HasBluetooth, opt => opt.Condition(src => src.HasBluetooth != null))
            .ForMember(dest => dest.HasCellular, opt => opt.Condition(src => src.HasCellular != null))            
            .ForMember(dest => dest.Weight, opt => opt.Condition(src => src.Weight != null))
            .ForMember(dest => dest.Dimensions, opt => opt.Condition(src => src.Dimensions != null))
            .ForMember(dest => dest.BuildMaterial, opt => opt.Condition(src => src.BuildMaterial != null))            
            .ForMember(dest => dest.OperatingSystem, opt => opt.Condition(src => src.OperatingSystem != null))
            .ForMember(dest => dest.SupportsStylus, opt => opt.Condition(src => src.SupportsStylus != null))
            .ForMember(dest => dest.HasFingerprintSensor, opt => opt.Condition(src => src.HasFingerprintSensor != null))
            .ForMember(dest => dest.HasFaceRecognition, opt => opt.Condition(src => src.HasFaceRecognition != null))
            .ForMember(dest => dest.IsWaterResistant, opt => opt.Condition(src => src.IsWaterResistant != null));
            

            CreateMap<Television, DtoTelevision>().ReverseMap();
            CreateMap<Television, AddTelevision>().ReverseMap();
            CreateMap<Television, UpdateTelevision>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.ScreenSize, opt => opt.Condition(src => src.ScreenSize != null))
            .ForMember(dest => dest.ScreenResolution, opt => opt.Condition(src => src.ScreenResolution != null))
            .ForMember(dest => dest.ScreenType, opt => opt.Condition(src => src.ScreenType != null))
            .ForMember(dest => dest.IsSmartTV, opt => opt.Condition(src => src.IsSmartTV != null))
            .ForMember(dest => dest.RefreshRate, opt => opt.Condition(src => src.RefreshRate != null))
            .ForMember(dest => dest.SupportsHDR, opt => opt.Condition(src => src.SupportsHDR != null))            
            .ForMember(dest => dest.SpeakerOutputPower, opt => opt.Condition(src => src.SpeakerOutputPower != null))
            .ForMember(dest => dest.SupportsDolbyAtmos, opt => opt.Condition(src => src.SupportsDolbyAtmos != null))            
            .ForMember(dest => dest.HdmiInputs, opt => opt.Condition(src => src.HdmiInputs != null))
            .ForMember(dest => dest.UsbPorts, opt => opt.Condition(src => src.UsbPorts != null))
            .ForMember(dest => dest.HasBluetooth, opt => opt.Condition(src => src.HasBluetooth != null))
            .ForMember(dest => dest.HasWiFi, opt => opt.Condition(src => src.HasWiFi != null))            
            .ForMember(dest => dest.OperatingSystem, opt => opt.Condition(src => src.OperatingSystem != null))
            .ForMember(dest => dest.SupportsVoiceControl, opt => opt.Condition(src => src.SupportsVoiceControl != null))
            .ForMember(dest => dest.HasScreenMirroring, opt => opt.Condition(src => src.HasScreenMirroring != null))            
            .ForMember(dest => dest.Weight, opt => opt.Condition(src => src.Weight != null))
            .ForMember(dest => dest.Dimensions, opt => opt.Condition(src => src.Dimensions != null))
            .ForMember(dest => dest.StandType, opt => opt.Condition(src => src.StandType != null))            
            .ForMember(dest => dest.EnergyRating, opt => opt.Condition(src => src.EnergyRating != null))
            .ForMember(dest => dest.PowerConsumption, opt => opt.Condition(src => src.PowerConsumption != null));


            CreateMap<Product, DtoProduct>().ReverseMap();
            CreateMap<Product, AddProduct>().ReverseMap();
            CreateMap<Product, UpdateProduct>().ReverseMap()
            .ForMember(dest => dest.Brand, opt => opt.Condition(src => src.Brand != null))
            .ForMember(dest => dest.Model, opt => opt.Condition(src => src.Model != null))
            .ForMember(dest => dest.Description, opt => opt.Condition(src => src.Description != null))
            .ForMember(dest => dest.Price, opt => opt.Condition(src => src.Price != null))
            //.ForMember(dest => dest.AllColorsStock, opt => opt.Condition(src => src.AllColorsStock != null))
            
            .ForMember(dest => dest.ProductCategoryId, opt => opt.Condition(src => src.ProductCategoryId != null))
            .ForMember(dest => dest.ProductColors, opt => opt.Condition(src => src.ProductColors != null && src.ProductColors.Any()))
            .ForMember(dest => dest.ProductProductTags, opt => opt.Condition(src => src.ProductProductTags != null && src.ProductProductTags.Any()))
            .ForMember(dest => dest.Reviews, opt => opt.Condition(src => src.Reviews != null && src.Reviews.Any()))
            .ForMember(dest => dest.Warranty, opt => opt.Condition(src => src.Warranty != null))
            
            .ForMember(dest => dest.Camera, opt => opt.Condition(src => src.Camera != null))
            .ForMember(dest => dest.DesktopPC, opt => opt.Condition(src => src.DesktopPC != null))
            .ForMember(dest => dest.GamingConsole, opt => opt.Condition(src => src.GamingConsole != null))
            .ForMember(dest => dest.Laptop, opt => opt.Condition(src => src.Laptop != null))
            .ForMember(dest => dest.Phone, opt => opt.Condition(src => src.Phone != null))
            .ForMember(dest => dest.Tablet, opt => opt.Condition(src => src.Tablet != null))
            .ForMember(dest => dest.Television, opt => opt.Condition(src => src.Television != null))
            
            .ForMember(dest => dest.Accessory, opt => opt.Condition(src => src.Accessory != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));


            CreateMap<ProductProductTag, DtoProductProductTag>().ReverseMap();
            CreateMap<ProductProductTag, AddProductProductTag>().ReverseMap();
            CreateMap<ProductProductTag, UpdateProductProductTag>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.ProductTagId, opt => opt.Condition(src => src.ProductTagId != null));


            CreateMap<ProductTag, DtoProductTag>().ReverseMap();
            CreateMap<ProductTag, AddProductTag>().ReverseMap();
            CreateMap<ProductTag, UpdateProductTag>().ReverseMap()
            .ForMember(dest => dest.Tag, opt => opt.Condition(src => src.Tag != null));


            CreateMap<Review, DtoReview>().ReverseMap();
            CreateMap<Review, AddReview>().ReverseMap();
            CreateMap<Review, UpdateReview>().ReverseMap()
            .ForMember(dest => dest.Rating, opt => opt.Condition(src => src.Rating != null))
            .ForMember(dest => dest.Comment, opt => opt.Condition(src => src.Comment != null));

            CreateMap<Warranty, DtoWarranty>().ReverseMap();
            CreateMap<Warranty, AddWarranty>().ReverseMap();
            CreateMap<Warranty, UpdateWarranty>().ReverseMap()
            .ForMember(dest => dest.Period_mm, opt => opt.Condition(src => src.Period_mm != null))
            .ForMember(dest => dest.CoverageDetails, opt => opt.Condition(src => src.CoverageDetails != null));

            CreateMap<Role, DtoRole>().ReverseMap();
            CreateMap<Role, AddRole>().ReverseMap();
            CreateMap<Role, UpdateRole>().ReverseMap()
            .ForMember(dest => dest.RoleName, opt => opt.Condition(src => src.RoleName != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));

            CreateMap<ShoppingCart, DtoShoppingCart>().ReverseMap();
            CreateMap<ShoppingCart, AddShoppingCart>().ReverseMap();
            CreateMap<ShoppingCart, UpdateShoppingCart>().ReverseMap()
            .ForMember(dest => dest.CartItems, opt => opt.Condition(src => src.CartItems != null));


            CreateMap<CartItem, DtoCartItem>().ReverseMap();
            CreateMap<CartItem, AddCartItem>().ReverseMap();
            CreateMap<CartItem, UpdateCartItem>().ReverseMap()
            .ForMember(dest => dest.Quantity, opt => opt.Condition(src => src.Quantity != null))
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null));


            CreateMap<WishlistItem, DtoWishlistItem>().ReverseMap();
            CreateMap<WishlistItem, AddWishlistItem>().ReverseMap();
            CreateMap<WishlistItem, UpdateWishlistItem>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null));


            CreateMap<Wishlist, DtoWishlist>().ReverseMap();
            CreateMap<Wishlist, AddWishlist>().ReverseMap();
            CreateMap<Wishlist, UpdateWishlist>().ReverseMap()
            .ForMember(dest => dest.CustomerId, opt => opt.Condition(src => src.CustomerId != null))
            .ForMember(dest => dest.WishlistItems, opt => opt.Condition(src => src.WishlistItems != null));


            CreateMap<UserNotification, DtoUserNotification>().ReverseMap();
            CreateMap<UserNotification, AddUserNotification>().ReverseMap();
            CreateMap<UserNotification, UpdateUserNotification>().ReverseMap()
            .ForMember(dest => dest.IsRead, opt => opt.Condition(src => src.IsRead != null));


            CreateMap<Notification, DtoNotification>().ReverseMap();
            CreateMap<Notification, AddNotification>().ReverseMap();
            CreateMap<AddNotificationForUser, AddNotification>().ReverseMap();
            CreateMap<Notification, UpdateNotification>().ReverseMap()
            .ForMember(dest => dest.Title, opt => opt.Condition(src => src.Title != null))
            .ForMember(dest => dest.Message, opt => opt.Condition(src => src.Message != null));


            CreateMap<OrderItem, DtoOrderItem>().ReverseMap();
            CreateMap<OrderItem, AddOrderItem>().ReverseMap();
            CreateMap<OrderItem, UpdateOrderItem>().ReverseMap()
            .ForMember(dest => dest.Id, opt => opt.Condition(src => src.Id != null))
            .ForMember(dest => dest.Quantity, opt => opt.Condition(src => src.Quantity != null))
            .ForMember(dest => dest.Price, opt => opt.Condition(src => src.Price != null))
            .ForMember(dest => dest.OrderId, opt => opt.Condition(src => src.OrderId != null))
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.FinalPrice, opt => opt.Condition(src => src.FinalPrice != null))
            .ForMember(dest => dest.ProductColorId, opt => opt.Condition(src => src.ProductColorId != null));

            CreateMap<Order, DtoOrder>().ReverseMap();
            CreateMap<Order, AddOrder>().ReverseMap();
            CreateMap<Order, UpdateOrder>().ReverseMap()
            .ForMember(dest => dest.TotalAmount, opt => opt.Condition(src => src.TotalAmount != null))
            .ForMember(dest => dest.AdressId, opt => opt.Condition(src => src.AdressId != null))
            .ForMember(dest => dest.CouponId, opt => opt.Condition(src => src.CouponId != null))
            .ForMember(dest => dest.PaymentMethodId, opt => opt.Condition(src => src.PaymentMethodId != null))
            .ForMember(dest => dest.OrderItems, opt => opt.Condition(src => src.OrderItems != null));


            CreateMap<DtoShoppingCart, AddOrder>()
            .ForMember(dest => dest.OrderItems, opt => opt.MapFrom(src => src.CartItems))
            .ReverseMap();
            CreateMap<DtoCartItem, AddOrderItem>().ReverseMap();



            CreateMap<PaymentMethod, DtoPaymentMethod>().ReverseMap();
            CreateMap<PaymentMethod, AddPaymentMethod>().ReverseMap();
            CreateMap<PaymentMethod, UpdatePaymentMethod>().ReverseMap()
            .ForMember(dest => dest.Type, opt => opt.Condition(src => src.Type != null))
            .ForMember(dest => dest.Provider, opt => opt.Condition(src => src.Provider != null));

            CreateMap<Coupon, DtoCoupon>().ReverseMap();
            CreateMap<Coupon, AddCoupon>().ReverseMap();
            CreateMap<Coupon, UpdateCoupon>().ReverseMap()
            .ForMember(dest => dest.Code, opt => opt.Condition(src => src.Code != null))
            .ForMember(dest => dest.DiscountAmount, opt => opt.Condition(src => src.DiscountAmount != null))
            .ForMember(dest => dest.MinPurchaseAmount, opt => opt.Condition(src => src.MinPurchaseAmount != null))
            .ForMember(dest => dest.MaxUsagePerCustomer, opt => opt.Condition(src => src.MaxUsagePerCustomer != null))
            .ForMember(dest => dest.ProductCategoryId, opt => opt.Condition(src => src.ProductCategoryId != null))
            .ForMember(dest => dest.AccessoryCategoryId, opt => opt.Condition(src => src.AccessoryCategoryId != null))
            .ForMember(dest => dest.StartDate, opt => opt.Condition(src => src.StartDate != null))
            .ForMember(dest => dest.EndDate, opt => opt.Condition(src => src.EndDate != null))
            .ForMember(dest => dest.IsActive, opt => opt.Condition(src => src.IsActive != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));

            CreateMap<News, DtoNews>().ReverseMap();
            CreateMap<News, AddNews>().ReverseMap();
            CreateMap<News, UpdateNews>().ReverseMap()
            .ForMember(dest => dest.Title, opt => opt.Condition(src => src.Title != null))
            .ForMember(dest => dest.Content, opt => opt.Condition(src => src.Content != null))
            .ForMember(dest => dest.DatePublished, opt => opt.Condition(src => src.DatePublished != null));

            CreateMap<ProductDiscount, DtoProductDiscount>().ReverseMap();
            CreateMap<ProductDiscount, AddProductDiscount>().ReverseMap();
            CreateMap<ProductDiscount, UpdateProductDiscount>().ReverseMap()
            .ForMember(dest => dest.ProductId, opt => opt.Condition(src => src.ProductId != null))
            .ForMember(dest => dest.DiscountId, opt => opt.Condition(src => src.DiscountId != null));

            CreateMap<Discount, DtoDiscount>().ReverseMap();
            CreateMap<Discount, AddDiscount>().ReverseMap()
               .ForMember(dest => dest.ProductDiscounts, opt => opt.Ignore());
            CreateMap<Discount, UpdateDiscount>().ReverseMap()
            .ForMember(dest => dest.DiscountType, opt => opt.Condition(src => src.DiscountType != null))
            .ForMember(dest => dest.Amount, opt => opt.Condition(src => src.Amount != null))
            .ForMember(dest => dest.StartDate, opt => opt.Condition(src => src.StartDate != null))
            .ForMember(dest => dest.EndDate, opt => opt.Condition(src => src.EndDate != null))
            .ForMember(dest => dest.IsActive, opt => opt.Condition(src => src.IsActive != null));

            CreateMap<Customer, DtoCustomer>().ReverseMap();
            CreateMap<Customer, AddCustomer>().ReverseMap();
            CreateMap<Customer, UpdateCustomer>().ReverseMap()
            .ForMember(dest => dest.LoyaltyPoints, opt => opt.Condition(src => src.LoyaltyPoints != null))
            .ForMember(dest => dest.Adresses, opt => opt.Condition(src => src.Adresses != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));

            CreateMap<Seller, DtoSeller>().ReverseMap();
            CreateMap<Seller, AddSeller>().ReverseMap();
            CreateMap<Seller, UpdateSeller>().ReverseMap()
            .ForMember(dest => dest.StoreName, opt => opt.Condition(src => src.StoreName != null))
            .ForMember(dest => dest.LicenseNumber, opt => opt.Condition(src => src.LicenseNumber != null))
            .ForMember(dest => dest.Adress, opt => opt.Condition(src => src.Adress != null))
            .ForMember(dest => dest.UserAccountId, opt => opt.Condition(src => src.UserAccountId != null))
            .ForMember(dest => dest.PersonId, opt => opt.Condition(src => src.PersonId != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));

            CreateMap<Adress, DtoAdress>().ReverseMap();
            CreateMap<Adress, AddAdress>().ReverseMap();
            CreateMap<Adress, UpdateAdress>().ReverseMap()
            .ForMember(dest => dest.Street, opt => opt.Condition(src => src.Street != null))
            .ForMember(dest => dest.City, opt => opt.Condition(src => src.City != null))
            .ForMember(dest => dest.Country, opt => opt.Condition(src => src.Country != null))
            .ForMember(dest => dest.PostalCode, opt => opt.Condition(src => src.PostalCode != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));

            CreateMap<Person, DtoPerson>().ReverseMap();
            CreateMap<Person, AddPerson>().ReverseMap();
            CreateMap<Person, UpdatePerson>().ReverseMap()
            .ForMember(dest => dest.FirstName, opt => opt.Condition(src => src.FirstName != null))
            .ForMember(dest => dest.LastName, opt => opt.Condition(src => src.LastName != null))
            .ForMember(dest => dest.DateOfBirth, opt => opt.Condition(src => src.DateOfBirth != null));

            CreateMap<CustomerCoupon, DtoCustomerCoupon>().ReverseMap();
            CreateMap<CustomerCoupon, AddCustomerCoupon>().ReverseMap();
            CreateMap<CustomerCoupon, UpdateCustomerCoupon>().ReverseMap()
            .ForMember(dest => dest.CustomerId, opt => opt.Condition(src => src.CustomerId != null))
            .ForMember(dest => dest.CouponId, opt => opt.Condition(src => src.CouponId != null))
            .ForMember(dest => dest.UsageCount, opt => opt.Condition(src => src.UsageCount != null));

            CreateMap<UserAccount, DtoUserAccount>().ReverseMap();
            CreateMap<UserAccount, AddUserAcc>().ReverseMap();
            CreateMap<UserAccount, UpdateUserAcc>().ReverseMap()
                .ForMember(dest => dest.Username, opt => opt.Condition(src => src.Username != null))
            .ForMember(dest => dest.Email, opt => opt.Condition(src => src.Email != null));

            CreateMap<Image, DtoImage>().ReverseMap();

            CreateMap<ProductImage, DtoProductImage>().ReverseMap();

            CreateMap<ProductColor, DtoProductColor>().ReverseMap();
            CreateMap<ProductColor, AddProductColor>().ReverseMap();
            CreateMap<ProductColor, UpdateProductColor>().ReverseMap()
            .ForMember(dest => dest.Name, opt => opt.Condition(src => src.Name != null))
            .ForMember(dest => dest.HexCode, opt => opt.Condition(src => src.HexCode != null))
            .ForMember(dest => dest.Stock, opt => opt.Condition(src => src.Stock != null));




            CreateMap<Electronics_Shop_17.Services.Database.ProductCategory, DtoProductCategory>().ReverseMap();
            CreateMap<Electronics_Shop_17.Model.Helpers.ProductCategory, DtoProductCategory>().ReverseMap();

            CreateMap<Electronics_Shop_17.Services.Database.ProductCategory, AddProductCategory>().ReverseMap();
            CreateMap<Electronics_Shop_17.Model.Helpers.ProductCategory, AddProductCategory>().ReverseMap();

            CreateMap<Electronics_Shop_17.Services.Database.ProductCategory, UpdateProductCategory>().ReverseMap()
            .ForMember(dest => dest.Name, opt => opt.Condition(src => src.Name != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));
            CreateMap<Electronics_Shop_17.Model.Helpers.ProductCategory, UpdateProductCategory>().ReverseMap()
            .ForMember(dest => dest.Name, opt => opt.Condition(src => src.Name != null))
            .ForMember(dest => dest.isDeleted, opt => opt.Condition(src => src.isDeleted != null));


        }
    }
}
