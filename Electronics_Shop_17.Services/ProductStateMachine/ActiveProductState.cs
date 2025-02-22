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

namespace Electronics_Shop_17.Services.ProductStateMachine
{
    public class ActiveProductState : BaseProductState
    {
        public ActiveProductState(DataContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("Update");
            actions.Add("SoftDelete");
            actions.Add("CheckStock");
            return actions;
        }

        public override async Task<DtoProduct> Update(int id, UpdateProduct request)
        {
            var dbObj = await _context.Products.FindAsync(id);

            _mapper.Map(request, dbObj);

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoProduct>(dbObj);
        }

        public override async Task<DtoProduct> SoftDelete(int id)
        {
            var dbObj = await _context.Products.FindAsync(id);

            dbObj.isDeleted = true;
            dbObj.StateMachine = "Archived";

            await _context.SaveChangesAsync();
            return _mapper.Map<DtoProduct>(dbObj);
        }

        public override async Task<DtoProduct> CheckStock(int id)
        {
            var dbObj = await _context.Products.Include(x=>x.ProductColors).FirstOrDefaultAsync(x=>x.Id==id);

            var stock = dbObj.ProductColors.All(x=>x.Stock==0);
            
            if (stock)
            {
                dbObj.StateMachine = "OutOfStock";
                await _context.SaveChangesAsync();
            }
            return _mapper.Map<DtoProduct>(dbObj);
        }
    }
}
