using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.InterfaceImplementations;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Org.BouncyCastle.Ocsp;
using Stripe;
using Stripe.Checkout;
using System.Text.Json;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class PendingOrderState : BaseOrderState
    {
        Checks _checks;
        IOrderValidationService _orderValidationService;
        private readonly string _stripeWebhookSecret;
        
        public PendingOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider, Checks checks, IOrderValidationService orderValidationService, IConfiguration config) : base(context, mapper, serviceProvider)
        {
            
            _checks = checks;
            _orderValidationService = orderValidationService;
            _stripeWebhookSecret = config["Stripe:WebhookSecret"];
            StripeConfiguration.ApiKey = config["Stripe:SecretKey"];
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("Confirm");
            actions.Add("Update");
            actions.Add("SoftDelete");
            actions.Add("BackToDraft");
            actions.Add("ApplyCoupon");
            actions.Add("DeleteOrderAndCoupon");
            return actions;
        }

        public override async Task HandleStripeWebhook(HttpRequest request)
        {
            Console.WriteLine("Webhook triggered in PendingOrderState");
            string json = await new StreamReader(request.Body).ReadToEndAsync();
            Console.WriteLine("Stripe JSON: " + json);
            Event stripeEvent;

            try
            {
                stripeEvent = EventUtility.ConstructEvent(
                    json,
                    request.Headers["Stripe-Signature"],
                    _stripeWebhookSecret,
                    throwOnApiVersionMismatch: false
                );
                Console.WriteLine("Stripe event type: " + stripeEvent.Type);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Webhook signature invalid: " + ex.Message);
                return;
            }

            
            if (!stripeEvent.Type.StartsWith("checkout.session."))
            {
                Console.WriteLine("Not a checkout.session event");
                return;
            }

            var session = stripeEvent.Data.Object as Stripe.Checkout.Session;

            if (session?.Metadata == null ||
                !session.Metadata.ContainsKey("order_id") ||
                !session.Metadata.ContainsKey("cart_id"))
            {
                Console.WriteLine("Metadata missing");
                return;
            }

            int orderId = int.Parse(session.Metadata["order_id"]);
            int cartId = int.Parse(session.Metadata["cart_id"]);

            Console.WriteLine($"OrderId: {orderId}, CartId: {cartId}");

            var order = await _context.Orders
                .Include(o => o.OrderItems)
                .FirstOrDefaultAsync(o => o.Id == orderId);

            if (order == null)
            {
                Console.WriteLine("Order not found");
                return;
            }

            Console.WriteLine("Order found: " + order.Id);

            
            using var doc = JsonDocument.Parse(json);
            var root = doc.RootElement;

            string? chargeId = null;
            string? paymentIntentId = null;

            if (root.TryGetProperty("data", out var data) &&
                data.TryGetProperty("object", out var obj))
            {
                if (obj.TryGetProperty("id", out var idProp))
                    chargeId = idProp.GetString();

                if (obj.TryGetProperty("payment_intent", out var piProp))
                    paymentIntentId = piProp.GetString();
            }

            
            if (stripeEvent.Type == "checkout.session.completed")
            {
                order.PaymentId = chargeId;
                order.PaymentIntent = paymentIntentId;

                await FinalizeOrderAsync(order, cartId);
                Console.WriteLine("FinalizeOrderAsync complete. Order state: " + order.StateMachine);
                return;
            }

            
            Console.WriteLine($"Checkout not successful ({stripeEvent.Type}). Returning order to Draft.");

            order.StateMachine = "Draft";

            await _context.SaveChangesAsync();

            Console.WriteLine($"Order {order.Id} returned to Draft");
        }



        public override async Task<DtoOrderSuggestion> ConfirmStripe(int id, int cartId)
        {
            var (order, suggestion) = await ValidateAndPrepareOrder(id);
            if (suggestion != null)
                return suggestion;

            var service = new SessionService();

            if (!string.IsNullOrEmpty(order.PaymentId))
            {
                try
                {
                    var existingSession = await service.GetAsync(order.PaymentId);
                    if (existingSession.Status != "expired")
                    {
                        return new DtoOrderSuggestion
                        {
                            sessionId = existingSession.Id,
                            oldOrder = _mapper.Map<DtoOrder>(order)
                        };
                    }
                }
                catch { }
            }

            var session = await service.CreateAsync(new SessionCreateOptions
            {
                PaymentMethodTypes = new() { "card" },
                Mode = "payment",

                LineItems = order.OrderItems.Select(item => new SessionLineItemOptions
                    {
                        Quantity = item.Quantity,
                        PriceData = new SessionLineItemPriceDataOptions
                        {
                            Currency = "eur",
                            UnitAmount = (long)(item.FinalPrice * 100),
                            ProductData = new SessionLineItemPriceDataProductDataOptions
                            {
                                Name = $"{item.Product.Brand} {item.Product.Model}"
                            }
                        }
                    }
                ).ToList(),

                SuccessUrl = "https://checkout.stripe.dev/success",
                CancelUrl = "https://checkout.stripe.dev/cancel",
                Metadata = new()
                {
                    { "order_id", order.Id.ToString() },
                    { "cart_id", cartId.ToString() }
                }
            });

            order.PaymentId = session.Id;
            await _context.SaveChangesAsync();

            return new DtoOrderSuggestion
            {
                sessionId = session.Id,
                oldOrder = _mapper.Map<DtoOrder>(order)
            };
        }


        public override async Task<DtoOrderSuggestion> Confirm(int id, int cartId)
        {
            var (order, suggestion) = await ValidateAndPrepareOrder(id);
            if (suggestion != null)
                return suggestion;

            await FinalizeOrderAsync(order,cartId);

            return new DtoOrderSuggestion
            {
                oldOrder = _mapper.Map<DtoOrder>(order)
            };
        }



        private async Task<(Order order, DtoOrderSuggestion? suggestion)>ValidateAndPrepareOrder(int orderId)
        {
            var order = await _context.Orders
                .Include(o => o.OrderItems).ThenInclude(x=>x.Product)
                .FirstOrDefaultAsync(o => o.Id == orderId);

            if (order == null)
                throw new KeyNotFoundException();

            var validation = await _orderValidationService.ValidateAsync(order);

            if (validation.HasChanges)
            {
                return (order, new DtoOrderSuggestion
                {
                    oldOrder = _mapper.Map<DtoOrder>(order),
                    newOrder = _mapper.Map<DtoOrder>(new Order
                    {
                        OrderItems = validation.CorrectedItems,
                        TotalAmount = validation.TotalAmount,
                        FinalTotalAmount = validation.FinalTotalAmount
                    })
                });
            }

            order.TotalAmount = validation.TotalAmount;
            order.FinalTotalAmount = validation.FinalTotalAmount;

            await _context.SaveChangesAsync();

            return (order, null);
        }

        private async Task FinalizeOrderAsync(Order order, int cartId)
        {
            if (order.StateMachine == "Completed")
                return; 

            await RemoveStock(order.OrderItems);
            await ResetShoppingCart(cartId);

            order.StateMachine = "Completed";
            await _context.SaveChangesAsync();
        }


        public async Task ResetShoppingCart(int cartId)
        {
            var dbObj = await _context.ShoppingCarts.Include(c => c.CartItems).FirstOrDefaultAsync(x => x.Id == cartId);
            if (dbObj == null)
                throw new Exception("No Shopping Cart Found");

            dbObj.CartItems.Clear();

            await _context.SaveChangesAsync();
        }

        public async Task RemoveStock(List<OrderItem> obj)
        {
            foreach (var item in obj)
            {
                var productColor = await _context.ProductColors.SingleOrDefaultAsync(x => x.Id == item.ProductColorId);

                if (productColor == null)
                    throw new KeyNotFoundException($"Product doesn't exist");
                if (productColor.Stock <= item.Quantity)
                    throw new InvalidOperationException($"Stock too low");

                productColor.Stock -= item.Quantity;
            }
            await _context.SaveChangesAsync();
        }

        public async override Task<DtoOrder> DeleteOrderAndCoupon(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var returnObj = _mapper.Map<DtoOrder>(dbObj);

            if (dbObj == null)
                throw new Exception("No Order found");

            if (dbObj.CouponId != null)
            {
                var couponCustomer = await _context.CustomerCoupons.Where(x=>x.CouponId==dbObj.CouponId && x.CustomerId==dbObj.CustomerId).FirstOrDefaultAsync();

                _context.Remove(couponCustomer);
            }

            _context.Remove(dbObj);

            await _context.SaveChangesAsync();

            return returnObj;
        }

        public override async Task<DtoOrder> SoftDelete(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);

            dbObj.isDeleted = true;
            dbObj.StateMachine = "Deleted";

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoOrder>(dbObj);
        }

        public override async Task<DtoOrder> BackToDraft(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);

            dbObj.StateMachine = "Draft";
            //dbObj.PaymentId = "";
            //dbObj.PaymentIntent = "";

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoOrder>(dbObj);
        }

        public override async Task<DtoOrder> ApplyCoupon(int id, int couponId)
        {
            var order = await _context.Orders.FindAsync(id);
            var coupon = await _context.Coupons.FindAsync(couponId);

            if (order != null && coupon != null && 
                DateTime.UtcNow>=coupon.StartDate &&
                DateTime.UtcNow <= coupon.EndDate &&
                coupon.IsActive)
            {
                if (order.TotalAmount >= coupon.MinPurchaseAmount && order.TotalAmount >=coupon.DiscountAmount)
                {
                    var customerCoupon = await _context.CustomerCoupons
                        .SingleOrDefaultAsync(x => x.CustomerId == order.CustomerId && x.CouponId == coupon.Id);

                    if (customerCoupon != null) { 
                        if(customerCoupon.UsageCount < coupon.MaxUsagePerCustomer)                        
                            customerCoupon.UsageCount++;
                    }
                    else
                    {
                        var insertObj = new CustomerCoupon()
                        {
                            CustomerId = order.CustomerId,
                            CouponId = coupon.Id,
                            UsageCount = 1
                        };
                        _context.CustomerCoupons.Add(insertObj);
                    }
                    order.CouponId = coupon.Id;
                    order.FinalTotalAmount=order.TotalAmount-coupon.DiscountAmount;
                    await _context.SaveChangesAsync();
                }
            }

            
            return _mapper.Map<DtoOrder>(order);
        }

        public override async Task<DtoOrder> Update(int id, UpdateOrder request)
        {
            var dbObj = await _context.Orders.FirstOrDefaultAsync(x => x.Id == id);

            _mapper.Map(request, dbObj);

            await _context.SaveChangesAsync();

            return _mapper.Map<DtoOrder>(dbObj);
        }

    }
}
