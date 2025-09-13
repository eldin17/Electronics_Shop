using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class DraftOrderState : BaseOrderState
    {
        IOrderItemService _orderItemService;
        IOrderService _orderService;
        Checks _checks;
        public DraftOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider, IOrderItemService orderItemService, Checks checks, IOrderService orderService) : base(context, mapper, serviceProvider)
        {
            _orderItemService = orderItemService;
            _orderService = orderService;
            _checks = checks;
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("AddItem");
            actions.Add("RemoveItem");
            actions.Add("SoftDelete");
            actions.Add("Update");
            actions.Add("CheckAndActivate");
            return actions;
        }

        public override async Task<DtoOrderSuggestion> CheckAndActivate(CheckAndActivateReq req)
        {
            var dbObj = await _context.Orders
            .Include(o => o.OrderItems)
            .FirstOrDefaultAsync(o => o.Id == req.OrderId);

            if (dbObj == null)
                throw new Exception($"Order {req.OrderId} not found");

            dbObj.AdressId = req.AdressId;
            dbObj.PaymentMethodId = req.PaymentMethodId;

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
                newOrder = hasChanges ? _mapper.Map<DtoOrder>(newOrderSuggestion) : null
            };

            if (!hasChanges)
            {
                dbObj.StateMachine = "Pending";
                //_context.Orders.Add(dbObj);

                if (dbObj.CouponId.HasValue)
                {
                    var dtoOrder = await _orderService.ApplyCoupon(dbObj.Id, dbObj.CouponId.Value);
                    obj.oldOrder.FinalTotalAmount = dtoOrder.FinalTotalAmount;
                }
                else
                {
                    obj.oldOrder.FinalTotalAmount = obj.oldOrder.TotalAmount;  
                }

                await _context.SaveChangesAsync();
            }
            else
            {
                obj.newOrder.FinalTotalAmount = obj.newOrder.TotalAmount;
            }


            return obj;
        }

        public override async Task<DtoOrder> AddItem(int id, int productColorId, int quantity)
        {
            var dbObj = await _context.Orders.Include(x => x.OrderItems).FirstOrDefaultAsync(x => x.Id == id);
            var productColor = await _context.OrderItems.FindAsync(productColorId);

            var newItem = new AddOrderItem()
            {
                Quantity = quantity,
                Price = productColor.Price,
                OrderId = dbObj.Id,
                ProductId = productColor.ProductId,
            };
            _orderItemService.Add(newItem);

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoOrder>(dbObj);
        }

        public override async Task<DtoOrder> RemoveItem(int id, int itemId)
        {
            var dbObj = await _context.Orders.Include(x => x.OrderItems).FirstOrDefaultAsync(x => x.Id == id);

            var orderItem = dbObj.OrderItems.FirstOrDefault(x=>x.Id == itemId);

            _context.OrderItems.Remove(orderItem);

            await _context.SaveChangesAsync();

            return _mapper.Map<DtoOrder>(dbObj);
        }

        public override async Task<DtoOrder> Delete(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);

            dbObj.isDeleted = true;
            dbObj.StateMachine = "Deleted";

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoOrder>(dbObj);
        }

        public override async Task<DtoOrder> Update(int id, UpdateOrder request)
        {
            var dbObj = await _context.Orders.FirstOrDefaultAsync(x=>x.Id==id);

            _mapper.Map(request, dbObj);

            await _context.SaveChangesAsync();

            return _mapper.Map<DtoOrder>(dbObj);
        }

        
    }
}
