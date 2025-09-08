using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentMethodController : BaseSoftDeleteController<DtoPaymentMethod, SearchPaymentMethod, AddPaymentMethod, UpdatePaymentMethod>
    {
        public PaymentMethodController(IPaymentMethodService service) : base(service)
        {
        }

        [HttpDelete("findAndDelete")]
        public async Task<DtoPaymentMethod> FindAndDelete(PayMethDel obj)
        {
            return await (_service as IPaymentMethodService).FindAndDelete(obj);
        }
    }
}
