using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Electronics_Shop_17.Services.OrderStateMachine;
using Electronics_Shop_17.Services.ProductStateMachine;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class OrderService : BaseServiceSoftDelete<DtoOrder, Order, SearchOrder, AddOrder, UpdateOrder>, IOrderService
    {
        BaseOrderState _baseOrderState;
        public OrderService(DataContext context, IMapper mapper, BaseOrderState baseOrderState) : base(context, mapper)
        {
            _baseOrderState = baseOrderState;
        }

        public override IQueryable<Order> AddInclude(IQueryable<Order> data)
        {
            data = data.Include(x => x.Customer).ThenInclude(x=>x.UserAccount).Include(x => x.Customer).ThenInclude(x => x.Person).Include(x => x.Adress).Include(x => x.Coupon).Include(x => x.PaymentMethod).Include(x => x.OrderItems);
            return base.AddInclude(data);
        }


        public override IQueryable<Order> AddFilter(IQueryable<Order> data, SearchOrder? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.MinOrderTime != null)
            {
                data = data.Where(x => x.OrderTime >= search.MinOrderTime);
            }
            if (search.MaxOrderTime != null)
            {
                data = data.Where(x => x.OrderTime <= search.MaxOrderTime);
            }
            if (search.TotalAmount != null)
            {
                data = data.Where(x => x.TotalAmount == search.TotalAmount);
            }
            if (search.MinTotalAmount != null)
            {
                data = data.Where(x => x.TotalAmount >= search.MinTotalAmount);
            }
            if (search.TotalAmount != null)
            {
                data = data.Where(x => x.TotalAmount <= search.MinTotalAmount);
            }
            if (search.CustomerId != null)
            {
                data = data.Where(x => x.CustomerId == search.CustomerId);
            }
            if (search.AdressId != null)
            {
                data = data.Where(x => x.AdressId == search.AdressId);
            }
            if (search.CouponId != null)
            {
                data = data.Where(x => x.CouponId == search.CouponId);
            }
            if (search.PaymentMethodId != null)
            {
                data = data.Where(x => x.PaymentMethodId == search.PaymentMethodId);
            }
            return base.AddFilter(data, search);
        }

        public async Task<List<string>> AllowedActionsInState(int id)
        {
            var obj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(obj.StateMachine);
            return await state.AllowedActionsInState();
        }

        public override async Task<DtoOrder> Update(int id, UpdateOrder updateRequest)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseOrderState.GetState(obj.StateMachine);
            return await state.Update(id, updateRequest);
        }

        public async Task<DtoOrderSuggestion> Confirm(int id, int cartId, string? paymentId = null, string? paymentIntent = null)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.Confirm(id, cartId, paymentId, paymentIntent);
        }

        public async Task<DtoOrder> BackToDraft(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.BackToDraft(id);
        }

        public async Task<DtoOrder> AddItem(int id, int productColorId, int quantity)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.AddItem(id, productColorId, quantity);
        }

        public async Task<DtoOrder> RemoveItem(int id, int itemId)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.RemoveItem(id, itemId);
        }
        
        public async Task<DtoOrderSuggestion> CheckAndActivate(CheckAndActivateReq req)
        {
            var dbObj = await _context.Orders.FindAsync(req.OrderId);

            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.CheckAndActivate(req);
        }        

        public async Task<DtoOrder> AddByCart(AddByCartReq request)
        {
            var state = _baseOrderState.GetState("Initial");
            return await state.AddByCart(request);
        }

        public async Task<DtoOrder> ApplyCoupon(int id, int couponId)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.ApplyCoupon(id, couponId);
        }

        public async Task<DtoOrder> DeleteOrderAndCoupon(int id)
        {
            var dbObj = await _context.Orders.FindAsync(id);
            var state = _baseOrderState.GetState(dbObj.StateMachine);
            return await state.DeleteOrderAndCoupon(id);
        }

        // nesto ovako
        //public async override Task<DtoShoppingCart> GetById(int id)
        //{
        //    var dbShoppingCart = await base.GetById(id);
        //    if (dbShoppingCart != null && dbShoppingCart.CartItems.IsNullOrEmpty())
        //        return dbShoppingCart;

        //    foreach (var item in dbShoppingCart.CartItems)
        //    {
        //        item.Product = await _productService.GetByIdWithChecks(dbShoppingCart.CustomerId, item.Product.Id);
        //    }

        //    return dbShoppingCart;
        //}

    }


}
