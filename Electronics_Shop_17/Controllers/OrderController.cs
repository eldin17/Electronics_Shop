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
    public class OrderController : BaseSoftDeleteController<DtoOrder, SearchOrder, AddOrder, UpdateOrder>
    {
        public OrderController(IOrderService service) : base(service)
        {
        }

        [HttpPatch("Confirm/{id}")]
        public virtual async Task<DtoOrderSuggestion> Confirm(int id, [FromBody] AddPaymentInfo? payment = null)
        {            
            return await (_service as IOrderService).Confirm(id, payment.CartId, payment?.PaymentId, payment?.PaymentIntent);
        }
        [HttpPatch("BackToDraft/{id}")]
        public virtual async Task<DtoOrder> BackToDraft(int id)
        {
            return await (_service as IOrderService).BackToDraft(id);
        }
        [HttpPatch("AddItem/{id}")]
        public virtual async Task<DtoOrder> AddItem(int id, int productColorId, int quantity)
        {
            return await (_service as IOrderService).AddItem(id, productColorId, quantity);
        }
        [HttpPatch("RemoveItem/{id}")]
        public virtual async Task<DtoOrder> RemoveItem(int id, int itemId)
        {
            return await (_service as IOrderService).RemoveItem(id, itemId);
        }
        
        [HttpPost("CheckAndActivate")]
        public virtual async Task<DtoOrderSuggestion> CheckAndActivate(CheckAndActivateReq req)
        {
            return await (_service as IOrderService).CheckAndActivate(req);
        }
        
        [HttpPatch("ApplyCoupon/{id}")]
        public virtual async Task<DtoOrder> ApplyCoupon(int id, int couponId)
        {
            return await (_service as IOrderService).ApplyCoupon(id, couponId);
        }
        [HttpGet("AllowedActionsInState/{id}")]
        public virtual async Task<List<string>> AllowedActionsInState(int id)
        {
            return await (_service as IOrderService).AllowedActionsInState(id);
        }
        [HttpPost("AddByCart")]
        public virtual async Task<DtoOrder> AddByCart(AddByCartReq request)
        {
            return await (_service as IOrderService).AddByCart(request);
        }
        [HttpDelete("DeleteOrderAndCoupon/{id}")]
        public virtual async Task<DtoOrder> DeleteOrderAndCoupon(int id)
        {
            return await (_service as IOrderService).DeleteOrderAndCoupon(id);
        }
    }
}
