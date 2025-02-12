using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaseCRUDController<T, TSearch, TAdd, TUpdate> : BaseController<T, TSearch> where TSearch : class
    {
        IBaseServiceCRUD<T, TSearch, TAdd, TUpdate> _service;
        public BaseCRUDController(IBaseServiceCRUD<T, TSearch, TAdd, TUpdate> service) : base(service)
        {
            _service = service;
        }

        [HttpPost]
        public virtual async Task<T> Add([FromBody] TAdd addRequest)
        {
            return await _service.Add(addRequest);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody] TUpdate updateRequest)
        {
            return await _service.Update(id, updateRequest);
        }

        [HttpDelete("{id}")]
        public virtual async Task<T> Delete(int id)
        {
            return await _service.Delete(id);
        }
    }
}
