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

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class CustomerCouponService : BaseServiceCRUD<DtoCustomerCoupon, CustomerCoupon, SearchCustomerCoupon, AddCustomerCoupon, UpdateCustomerCoupon>, ICustomerCouponService
    {
        public CustomerCouponService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<CustomerCoupon> AddFilter(IQueryable<CustomerCoupon> data, SearchCustomerCoupon? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.CustomerId != null)
            {
                data = data.Where(x => x.CustomerId == search.CustomerId);
            }
            if (search.CouponId != null)
            {
                data = data.Where(x => x.CouponId == search.CouponId);
            }
            if (search.UsageCount != null)
            {
                data = data.Where(x => x.UsageCount == search.UsageCount);
            }
            return base.AddFilter(data, search);
        }
    }
}
