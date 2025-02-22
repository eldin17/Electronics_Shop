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
        public DraftOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider, IOrderItemService orderItemService) : base(context, mapper, serviceProvider)
        {
            _orderItemService = orderItemService;
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("AddItem");
            actions.Add("RemoveItem");
            actions.Add("SoftDelete");
            actions.Add("Update");
            actions.Add("Activate");
            return actions;
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

        public override async Task<DtoOrder> Activate(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);
                        
            dbObj.StateMachine = "Pending";

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoOrder>(dbObj);
        }
    }
}
