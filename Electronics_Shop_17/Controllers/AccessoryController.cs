using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccessoryController : BaseCRUDController<DtoAccessory, SearchAccessory, AddAccessory, UpdateAccessory>
    {
        
        public AccessoryController(IAccessoryService service, DataContext context, IMapper mapper) : base(service)
        {
            
        }
    }
}
