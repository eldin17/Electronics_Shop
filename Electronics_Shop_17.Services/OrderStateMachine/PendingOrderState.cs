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
        public PendingOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("CheckAndAdd");
            actions.Add("Confirm");
            actions.Add("SoftDelete");
            actions.Add("BackToDraft");
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
                var stockCheckedItem = await Checks.StockCheck(item);
                var priceCheckedItem = await Checks.PriceCheck(item.ProductId);
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
            newOrderSuggestion.OrderItems.Clear();
            newOrderSuggestion.TotalAmount = 0;
            bool hasChanges = false;

            foreach (var item in dbObj.OrderItems) {
                var stockCheckedItem = await Checks.StockCheck(item);
                var priceCheckedItem = await Checks.PriceCheck(item.ProductId);
                if(item.Quantity!=stockCheckedItem.Quantity || item.FinalPrice != priceCheckedItem.FinalPrice)
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
                dbObj.StateMachine = "Completed";
                if(paymentId!=null && paymentIntent != null)
                {
                    dbObj.PaymentId = paymentId;
                    dbObj.PaymentIntent = paymentIntent;                        
                }
                await _context.SaveChangesAsync();
            }

            return obj;
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
    }
}
