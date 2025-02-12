using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaseSoftDeleteController<T, TSearch, TAdd, TUpdate> : BaseCRUDController<T, TSearch, TAdd, TUpdate> where TSearch : class
    {
        IBaseServiceSoftDelete<T, TSearch, TAdd, TUpdate> _service;

        public BaseSoftDeleteController(IBaseServiceSoftDelete<T, TSearch, TAdd, TUpdate> service) : base(service)
        {
            _service = service;
        }

        [HttpPatch("SoftDelete/{id}")]
        public virtual async Task<T> SoftDelete(int id)
        {
            return await _service.SoftDelete(id);
        }
    }
}
