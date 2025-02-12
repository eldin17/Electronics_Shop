using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApplicationModels;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductProductTagController : BaseCRUDController<DtoProductProductTag, SearchProductProductTag, AddProductProductTag, UpdateProductProductTag>
    {
        public ProductProductTagController(IProductProductTagService service) : base(service)
        {
        }
    }
}
