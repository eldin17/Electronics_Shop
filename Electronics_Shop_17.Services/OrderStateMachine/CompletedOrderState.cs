using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Services.Database;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class CompletedOrderState : BaseOrderState
    {
        public CompletedOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }
    }
}
