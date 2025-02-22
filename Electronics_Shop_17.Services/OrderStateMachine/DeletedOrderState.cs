using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Services.Database;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class DeletedOrderState : BaseOrderState
    {
        public DeletedOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("Delete");
            return actions;
        }

        public override async Task<DtoOrder> Delete(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);

            _context.Orders.Remove(dbObj);

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoOrder>(dbObj);
        }
    }
}
