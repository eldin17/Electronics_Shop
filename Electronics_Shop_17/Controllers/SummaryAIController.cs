using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SummaryAIController : ControllerBase
    {
        private ISummaryAIService _summaryAIService;

        public SummaryAIController(ISummaryAIService summaryAiService)
        {
            _summaryAIService = summaryAiService;
        }


        [HttpGet("{productId}/reviews-summary")]
        public async Task<IActionResult> GetProductReviewSummary(int productId, [FromQuery] bool forceRefresh = false)
        {                   
            string summary = await _summaryAIService.GetOrCreateSummaryAsync(productId, forceRefresh);
            
            return Ok(new
            {
                ProductId = productId,
                Summary = summary
            });            
        }
    }
}
