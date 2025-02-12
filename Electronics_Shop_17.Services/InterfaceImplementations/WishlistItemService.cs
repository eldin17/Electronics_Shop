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
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class WishlistItemService : BaseServiceCRUD<DtoWishlistItem, WishlistItem, SearchWishlistItem, AddWishlistItem, UpdateWishlistItem>, IWishlistItemService
    {
        public WishlistItemService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<WishlistItem> AddInclude(IQueryable<WishlistItem> data)
        {
            data = data.Include(x => x.Product);
            return base.AddInclude(data);
        }


        public override IQueryable<WishlistItem> AddFilter(IQueryable<WishlistItem> data, SearchWishlistItem? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (search.WishlistId != null)
            {
                data = data.Where(x => x.WishlistId == search.WishlistId);
            }
            return base.AddFilter(data, search);
        }
    }
}
