﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Services.Database;
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

        public virtual async Task<DtoOrderSuggestion> CheckAndAdd(AddOrder request)
        {
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrderSuggestion> Confirm(int id, string? paymentId = null, string? paymentIntent = null)
        {            
            throw new Exception("Action Not Allowed :(");
        }
        public virtual async Task<DtoOrder> Delete(int id)
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
        public virtual async Task<DtoOrder> Activate(int id)
        {
            throw new Exception("Action Not Allowed :(");
        }
    }
}
