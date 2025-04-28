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
    public class CouponService : BaseServiceSoftDelete<DtoCoupon, Coupon, SearchCoupon, AddCoupon, UpdateCoupon>, ICouponService
    {
        public CouponService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Coupon> AddFilter(IQueryable<Coupon> data, SearchCoupon? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Code))
            {
                data = data.Where(x => x.Code.Contains(search.Code));
            }
            if (search.DiscountAmount != null)
            {
                data = data.Where(x => x.DiscountAmount == search.DiscountAmount);
            }
            if (search.MinPurchaseAmount != null)
            {
                data = data.Where(x => x.MinPurchaseAmount == search.MinPurchaseAmount);
            }
            if (search.MaxUsagePerCustomer != null)
            {
                data = data.Where(x => x.MaxUsagePerCustomer == search.MaxUsagePerCustomer);
            }
            if (search.ProductCategoryId != null)
            {
                data = data.Where(x => x.ProductCategoryId == search.ProductCategoryId);
            }
            if (search.AccessoryCategoryId != null)
            {
                data = data.Where(x => x.AccessoryCategoryId == search.AccessoryCategoryId);
            }
            if (search.StartDate != null)
            {
                data = data.Where(x => x.StartDate >= search.StartDate);
            }
            if (search.EndDate != null)
            {
                data = data.Where(x => x.EndDate <= search.EndDate);
            }
            if (search.IsActive != null)
            {
                data = data.Where(x => x.IsActive == search.IsActive);
            }
            if (search.isDeleted != null)
            {
                data = data.Where(x => x.isDeleted == search.isDeleted);
            }
            return base.AddFilter(data, search);
        }

        public async Task<DtoCoupon> CouponCheck(string couponCode, int customerId, double purchaseAmount)
        {
            var dbCoupon = await _context.Coupons.FirstOrDefaultAsync(x=>x.Code == couponCode && !x.isDeleted);
            if(dbCoupon != null)
            {
                if (dbCoupon.DiscountAmount < purchaseAmount 
                    && dbCoupon.MinPurchaseAmount < purchaseAmount
                    && dbCoupon.StartDate < DateTime.UtcNow
                    && dbCoupon.EndDate > DateTime.UtcNow
                    && dbCoupon.IsActive) 
                {
                    var dbCustomerCoupon = await _context.CustomerCoupons.FirstOrDefaultAsync(x => x.CustomerId == customerId && x.CouponId == dbCoupon.Id);
                    
                    if (dbCustomerCoupon != null) {
                        if (dbCustomerCoupon.UsageCount < dbCoupon.MaxUsagePerCustomer)                        
                            return _mapper.Map<DtoCoupon>(dbCoupon);                        
                        else
                            return new DtoCoupon();
                    }else
                        return _mapper.Map<DtoCoupon>(dbCoupon);
                }
            }
            return new DtoCoupon();
        }
    }
}
