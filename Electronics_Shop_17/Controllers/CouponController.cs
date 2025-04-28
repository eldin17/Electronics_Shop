using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CouponController : BaseSoftDeleteController<DtoCoupon, SearchCoupon, AddCoupon, UpdateCoupon>
    {
        public CouponController(ICouponService service) : base(service)
        {
        }

        [HttpGet("CouponCheck")]
        public async Task<DtoCoupon> CouponCheck(string couponCode, int customerId, double purchaseAmount)
        {
            return await (_service as ICouponService).CouponCheck(couponCode, customerId, purchaseAmount);
        }

    }
}
