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
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class OrderService : BaseServiceCRUD<DtoOrder, Order, SearchOrder, AddOrder, UpdateOrder>, IOrderService
    {
        public OrderService(DataContext context, IMapper mapper) : base(context, mapper)
        {
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
    }
}
