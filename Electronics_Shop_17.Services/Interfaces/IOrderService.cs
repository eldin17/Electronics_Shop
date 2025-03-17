using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IOrderService : IBaseServiceSoftDelete<DtoOrder,SearchOrder,AddOrder,UpdateOrder>
    {
        Task<DtoOrderSuggestion> Confirm(int id, string? paymentId = null, string? paymentIntent = null);
        Task<DtoOrder> BackToDraft(int id);
        Task<DtoOrder> AddItem(int id, int productColorId, int quantity);
        Task<DtoOrder> RemoveItem(int id, int itemId);
        Task<DtoOrder> Activate(int id);
        Task<DtoOrderSuggestion> CheckAndAdd(AddOrder request);
        Task<DtoOrder> ApplyCoupon(int id, int couponId);
    }
}
