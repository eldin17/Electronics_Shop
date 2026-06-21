using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController : BaseController<DtoImage, SearchImage>
    {
        public ImageController(IImageService service) : base(service)
        {
        }

        [HttpPost("AddMultipleImages/{id}")]
        public async Task<ActionResult<DtoProduct>> AddMultipleImages(int id, [FromForm] ImgMultipleVM obj)
        {
            var result = await (_service as IImageService).AddMultipleImages(id, obj);
            return Ok(result);
        }

        [HttpPost("AddSingleImage/{id}")]
        public async Task<ActionResult<DtoUserAccount>> AddSingleImage(int id, [FromForm] ImgSingleVM obj)
        {
            var result = await (_service as IImageService).AddSingleImage(id, obj);
            return Ok(result);
        }
    }
}
