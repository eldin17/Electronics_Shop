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
            return await (_service as IOrderService).Confirm(id, payment?.PaymentId, payment?.PaymentIntent);
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
        [HttpPatch("Activate/{id}")]
        public virtual async Task<DtoOrder> Activate(int id)
        {
            return await (_service as IOrderService).Activate(id);
        }
        [HttpPost("CheckAndAdd")]
        public virtual async Task<DtoOrderSuggestion> CheckAndAdd(AddOrder request)
        {
            return await (_service as IOrderService).CheckAndAdd(request);
        }
        [HttpPatch("ApplyCoupon/{id}")]
        public virtual async Task<DtoOrder> ApplyCoupon(int id, int couponId)
        {
            return await (_service as IOrderService).ApplyCoupon(id, couponId);
        }
    }
}
