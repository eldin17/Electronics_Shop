using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Microsoft.AspNetCore.Http;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IOrderService : IBaseServiceSoftDelete<DtoOrder,SearchOrder,AddOrder,UpdateOrder>
    {
        Task<DtoOrderSuggestion> Confirm(int id, int cartId);
        Task<DtoOrderSuggestion> ConfirmStripe(int id, int cartId);
        Task HandleStripeWebhook(HttpRequest request); 
        Task<DtoOrder> BackToDraft(int id);
        Task<DtoOrder> AddItem(int id, int productColorId, int quantity);
        Task<DtoOrder> RemoveItem(int id, int itemId);
        Task<DtoOrderSuggestion> CheckAndActivate(CheckAndActivateReq req);
        Task<DtoOrder> ApplyCoupon(int id, int couponId);
        Task<List<string>> AllowedActionsInState(int id);
        Task<DtoOrder> AddByCart(AddByCartReq request);
        Task<DtoOrder> DeleteOrderAndCoupon(int id);

    }
}
