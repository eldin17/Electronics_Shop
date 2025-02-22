using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.ProductStateMachine
{
    public class ArchivedProductState : BaseProductState
    {
        public ArchivedProductState(DataContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("Restore");
            actions.Add("Delete");
            return actions;
        }

        public override async Task<DtoProduct> Restore(int id)
        {
            var dbObj = await _context.Products.FindAsync(id);

            dbObj.isDeleted = false;
            dbObj.StateMachine = "Draft";

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoProduct>(dbObj);
        }

        public override async Task<DtoProduct> Delete(int id)
        {
            var dbObj = await _context.Products.FindAsync(id);

            _context.Products.Remove(dbObj);

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoProduct>(dbObj);
        }
    }
}
