using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class OrderItemService : BaseServiceCRUD<DtoOrderItem, OrderItem, SearchOrderItem, AddOrderItem, UpdateOrderItem>, IOrderItemService
    {
        public OrderItemService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<OrderItem> AddFilter(IQueryable<OrderItem> data, SearchOrderItem? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.Quantity != null)
            {
                data = data.Where(x => x.Quantity == search.Quantity);
            }
            if (search.Price != null)
            {
                data = data.Where(x => x.Price == search.Price);
            }
            if (search.OrderId != null)
            {
                data = data.Where(x => x.OrderId == search.OrderId);
            }            
            return base.AddFilter(data, search);
        }
    }
}
