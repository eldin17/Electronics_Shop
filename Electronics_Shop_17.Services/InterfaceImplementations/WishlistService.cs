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
using Microsoft.IdentityModel.Tokens;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class WishlistService : BaseServiceCRUD<DtoWishlist, Wishlist, SearchWishlist, AddWishlist, UpdateWishlist>, IWishlistService
    {
        IProductService _productService;
        public WishlistService(DataContext context, IMapper mapper, IProductService productService) : base(context, mapper)
        {
            _productService = productService;
        }

        public override IQueryable<Wishlist> AddInclude(IQueryable<Wishlist> data)
        {
            data = data.Include(x => x.WishlistItems);
            return base.AddInclude(data);
        }

        public override IQueryable<Wishlist> AddFilter(IQueryable<Wishlist> data, SearchWishlist? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.CustomerId != null)
            {
                data = data.Where(x => x.CustomerId == search.CustomerId);
            }
            if (search.DateCreated != null)
            {
                data = data.Where(x => x.DateCreated == search.DateCreated);
            }
            return base.AddFilter(data, search);
        }

        public async override Task<DtoWishlist> GetById(int id)
        {
            var dbWishlist = await base.GetById(id);
            if (dbWishlist != null && dbWishlist.WishlistItems.IsNullOrEmpty())
                return dbWishlist;

            foreach (var item in dbWishlist.WishlistItems)
            {
                item.Product = await _productService.GetByIdWithChecks(dbWishlist.CustomerId, item.Product.Id);
            }

            return dbWishlist;
        }
    }
}
