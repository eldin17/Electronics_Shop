using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class BaseOrderState
    {
        protected DataContext _context;
        protected IMapper _mapper;
        protected IServiceProvider _serviceProvider;

        public BaseOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public BaseOrderState GetState(string state)
        {
            switch (state)
            {
                case "Initial":
                    return _serviceProvider.GetService<InitialOrderState>();
                    break;
                case "Draft":
                    return _serviceProvider.GetService<DraftOrderState>();
                    break;
                case "Pending":
                    return _serviceProvider.GetService<PendingOrderState>();
                    break;
                case "Completed":
                    return _serviceProvider.GetService<CompletedOrderState>();
                    break;
                case "Deleted":
                    return _serviceProvider.GetService<DeletedOrderState>();
                    break;
                default:
                    throw new Exception("Action Not Allowed :(");
            }
        }

        public virtual async Task<List<string>> AllowedActionsInState()
        {
            return new List<string>();
        }

        public virtual async Task<DtoOrderSuggestion> CheckAndActivate(CheckAndActivateReq req)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> Add(DtoShoppingCart request)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrderSuggestion> Confirm(int id, int cartId)
        {            
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrderSuggestion> ConfirmStripe(int id, int cartId)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task HandleStripeWebhook(HttpRequest request)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> Delete(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> DeleteOrderAndCoupon(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> SoftDelete(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> BackToDraft(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> AddItem(int id, int productColorId, int quantity)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> RemoveItem(int id, int itemId)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> Update(int id, UpdateOrder request)
        {
            throw new Exception("Action Not Allowed :(");
        }       
        public virtual async Task<DtoOrder> ApplyCoupon(int id, int couponId)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> AddByCart(AddByCartReq request)
        {
            throw new Exception("Action Not Allowed :(");
        }
    }
}
