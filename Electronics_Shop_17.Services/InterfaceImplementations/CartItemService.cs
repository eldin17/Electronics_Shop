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
    public class CartItemService : BaseServiceCRUD<DtoCartItem, CartItem, SearchCartItem, AddCartItem, UpdateCartItem>, ICartItemService
    {
        public CartItemService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<CartItem> AddFilter(IQueryable<CartItem> data, SearchCartItem? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.Quantity != null)
            {
                data = data.Where(x => x.Quantity == search.Quantity);
            }
            if (search.MinQuantity != null)
            {
                data = data.Where(x => x.Quantity >= search.MinQuantity);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (search.ShoppingCartId != null)
            {
                data = data.Where(x => x.ShoppingCartId == search.ShoppingCartId);
            }
            return base.AddFilter(data, search);
        }
    }
}
