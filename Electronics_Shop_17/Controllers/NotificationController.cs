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
    public class NotificationController : BaseCRUDController<DtoNotification, SearchNotification, AddNotification, UpdateNotification>
    {
        public NotificationController(INotificationService service) : base(service)
        {            
        }

        [HttpPost("AddForUser")]
        public async Task<DtoNotification> AddForUser(AddNotificationForUser addRequest)
        {
            return await (_service as INotificationService).AddForUser(addRequest);
        }

        [HttpGet("GetAllForUser/{userAccountId}")]
        public async Task<Pagination<DtoNotification>> GetAllForUser(int userAccountId, [FromQuery] SearchNotification? search = null)
        {
            return await (_service as INotificationService).GetAllForUser(userAccountId, search);
        }

        [HttpPost("MarkAsRead/{userAccId}/{notificationId}")]
        public async Task<string> MarkAsRead(int userAccId, int notificationId)
        {
            return await (_service as INotificationService).MarkAsRead(userAccId, notificationId);
        }
    }
}
