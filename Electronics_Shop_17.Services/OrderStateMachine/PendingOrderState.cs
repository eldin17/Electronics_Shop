using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Ocsp;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class PendingOrderState : BaseOrderState
    {
        Checks _checks;
        public PendingOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider, Checks checks) : base(context, mapper, serviceProvider)
        {
            _checks = checks;
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

        

        public override async Task<DtoOrderSuggestion> Confirm(int id, int cartId, string? paymentId = null, string? paymentIntent = null )
        {
            var dbObj = await _context.Orders
            .Include(o => o.OrderItems)
            .FirstOrDefaultAsync(o => o.Id == id);

            if (dbObj == null)
                throw new KeyNotFoundException($"Order with id {id} not found");

            var newOrderSuggestion = _mapper.Map<DtoOrder>(dbObj);
            var orderItemsList = new List<DtoOrderItem>();
            
            newOrderSuggestion.TotalAmount = 0;
            bool hasChanges = false;

            foreach (var item in dbObj.OrderItems) {
                var stockCheckedItem = await _checks.StockCheck(item);
                var priceCheckedItem = await _checks.PriceCheck(item.ProductId);
                if(item.Quantity!=stockCheckedItem.Quantity || item.FinalPrice != priceCheckedItem.FinalPrice)
                {
                    var newItemSuggestion = _mapper.Map<DtoOrderItem>(item);
                    newItemSuggestion.Quantity = stockCheckedItem.Quantity;
                    newItemSuggestion.FinalPrice = priceCheckedItem.FinalPrice;

                    orderItemsList.Add(newItemSuggestion);
                    newOrderSuggestion.TotalAmount += newItemSuggestion.FinalPrice;

                    hasChanges = true;
                }
                else
                {
                    orderItemsList.Add(_mapper.Map<DtoOrderItem>(item));
                    newOrderSuggestion.TotalAmount += item.FinalPrice;
                }
            }
            var obj = new DtoOrderSuggestion()
            {
                oldOrder = _mapper.Map<DtoOrder>(dbObj),
                newOrder = hasChanges ? _mapper.Map<DtoOrder>(newOrderSuggestion) : null                
            };
           
            if (!hasChanges)
            {
                await RemoveStock(dbObj.OrderItems);
                await ResetShoppingCart(cartId);
                dbObj.StateMachine = "Completed";
                if(paymentId!=null && paymentIntent != null)
                {
                    dbObj.PaymentId = paymentId;
                    dbObj.PaymentIntent = paymentIntent;                        
                }

                

                await _context.SaveChangesAsync();
            }
            else
            {
                obj.newOrder.OrderItems= orderItemsList;                
            }

            return obj;
        }

        public async Task ResetShoppingCart(int cartId)
        {
            var dbObj = await _context.Set<ShoppingCart>().FirstOrDefaultAsync(x => x.Id == cartId);
            if (dbObj == null)
                throw new Exception("No Shopping Cart Found");

            dbObj.CartItems = new List<CartItem>();

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
