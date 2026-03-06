using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Services.AI_Recommendations;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Stripe;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecommendationController : ControllerBase
    {
        IRecommendationService _service;
        public RecommendationController(IRecommendationService service)
        {
            _service = service;
        }

        [HttpGet("{productId}")]
        public ActionResult<List<DtoProduct>> GetRecommendations(int productId, [FromQuery] int take = 3)
        {
            var results = _service.GetRecommendations(productId, take);
            return Ok(results); 
        }

        [HttpPost("Train")]        
        public IActionResult TrainModel()
        {
            _service.TrainModel();
            return Ok("Model trained and saved to /Data folder.");
        }

    }
}
