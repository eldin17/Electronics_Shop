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
    public class DiscountController : BaseCRUDController<DtoDiscount, SearchDiscount, AddDiscount, UpdateDiscount>
    {
        public DiscountController(IDiscountService service) : base(service)
        {
        }

        [HttpGet("GetOneRandom")]
        public async Task<ActionResult<DtoDiscount>> GetOneRandom()
        {
            return await (_service as IDiscountService).GetOneRandom();
        }
    }
}
