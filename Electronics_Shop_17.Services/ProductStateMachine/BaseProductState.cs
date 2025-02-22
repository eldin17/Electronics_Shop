using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;
using Microsoft.Extensions.DependencyInjection;

namespace Electronics_Shop_17.Services.ProductStateMachine
{
    public class BaseProductState
    {
        protected DataContext _context;
        protected IMapper _mapper;
        protected IServiceProvider _serviceProvider;
        public BaseProductState(DataContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public BaseProductState GetState(string state)
        {
            switch (state)
            {
                case "Initial":
                    return _serviceProvider.GetService<InitialProductState>();
                    break;

                case "Draft":
                    return _serviceProvider.GetService<DraftProductState>();
                    break;

                case "Active":
                    return _serviceProvider.GetService<ActiveProductState>();
                    break;

                case "OutOfStock":
                    return _serviceProvider.GetService<OutOfStockProductState>();
                    break;
                case "Archived":
                    return _serviceProvider.GetService<ArchivedProductState>();
                    break;

                default:
                    throw new Exception("Action Not Allowed :(");
            }
        }

        public virtual async Task<List<string>> AllowedActionsInState()
        {
            return new List<string>();
        }

        public virtual async Task<DtoProduct> Add(AddProduct request)
        {
            throw new Exception("Action Not Allowed :(");
        }

        public virtual async Task<DtoProduct> Update(int id, UpdateProduct request)
        {
            throw new Exception("Action Not Allowed :(");
        }

        public virtual async Task<DtoProduct> Activate(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }

        public virtual async Task<DtoProduct> Delete(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoProduct> SoftDelete(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoProduct> CheckStock(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoProduct> Restock(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoProduct> Restore(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
    }
}
