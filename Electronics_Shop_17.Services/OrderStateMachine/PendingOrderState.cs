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
            actions.Add("CheckAndAdd");
            actions.Add("Confirm");
            actions.Add("Update");
            actions.Add("SoftDelete");
            actions.Add("BackToDraft");
            actions.Add("ApplyCoupon");
            return actions;
        }

        public override async Task<DtoOrderSuggestion> CheckAndAdd(AddOrder request)
        {
            var dbObj = _mapper.Map<Order>(request);

            var newOrderSuggestion = _mapper.Map<DtoOrder>(dbObj);
            newOrderSuggestion.OrderItems.Clear();
            newOrderSuggestion.TotalAmount = 0;
            bool hasChanges = false;

            foreach (var item in dbObj.OrderItems)
            {
                var stockCheckedItem = await _checks.StockCheck(item);
                var priceCheckedItem = await _checks.PriceCheck(item.ProductId);
                if (item.Quantity != stockCheckedItem.Quantity || item.FinalPrice != priceCheckedItem.FinalPrice)
                {
                    var newItemSuggestion = _mapper.Map<DtoOrderItem>(item);
                    newItemSuggestion.Quantity = stockCheckedItem.Quantity;
                    newItemSuggestion.FinalPrice = priceCheckedItem.FinalPrice;

                    newOrderSuggestion.OrderItems.Add(newItemSuggestion);
                    newOrderSuggestion.TotalAmount += newItemSuggestion.FinalPrice;

                    hasChanges = true;
                }
                else
                {
                    newOrderSuggestion.OrderItems.Add(_mapper.Map<DtoOrderItem>(item));
                    newOrderSuggestion.TotalAmount += item.FinalPrice;
                }
            }
            var obj = new DtoOrderSuggestion()
            {
                oldOrder = _mapper.Map<DtoOrder>(dbObj),
                newOrder = hasChanges ? _mapper.Map<DtoOrder>(newOrderSuggestion) : new DtoOrder()
            };

            if (!hasChanges)
            {
                _context.Orders.Add(dbObj);

                await _context.SaveChangesAsync();
            }

            return obj;
        }

        public override async Task<DtoOrderSuggestion> Confirm(int id, string? paymentId = null, string? paymentIntent = null)
        {            
            var dbObj = await _context.Orders.Include(x=>x.OrderItems).ThenInclude(x=>x.ProductColor)
                .Include(x => x.OrderItems).ThenInclude(x => x.Product)
                .SingleOrDefaultAsync(x=>x.Id==id);
            if (dbObj == null)
                throw new KeyNotFoundException($"Order with id {id} not found");

            var newOrderSuggestion = _mapper.Map<DtoOrder>(dbObj);
            var orderItemsList = new List<DtoOrderItem>();
            //newOrderSuggestion.OrderItems.Clear();//ovdje ce brisati i iz dbObj, prepraviti
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
                newOrder = hasChanges ? _mapper.Map<DtoOrder>(newOrderSuggestion) : new DtoOrder()                
            };
           
            if (!hasChanges)
            {
                RemoveStock(dbObj.OrderItems);
                dbObj.StateMachine = "Completed";
                if(paymentId!=null && paymentIntent != null)
                {
                    dbObj.PaymentId = paymentId;
                    dbObj.PaymentIntent = paymentIntent;                        
                }

                await _context.SaveChangesAsync();
            }
            else
                obj.newOrder.OrderItems= orderItemsList;

                return obj;
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
