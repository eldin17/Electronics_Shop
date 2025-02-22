using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;

namespace Electronics_Shop_17.Services.ProductStateMachine
{
    public class InitialProductState : BaseProductState
    {
        public InitialProductState(DataContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("Add");
            return actions;
        }

        public override async Task<DtoProduct> Add(AddProduct request)
        {
            var obj = _mapper.Map<Product>(request);

            obj.StateMachine = "Draft";

            _context.Set<Product>().Add(obj);

            await _context.SaveChangesAsync();

            return _mapper.Map<DtoProduct>(obj);
        }
    }
}
