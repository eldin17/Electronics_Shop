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
    public class ShoppingCartService : BaseServiceCRUD<DtoShoppingCart, ShoppingCart, SearchShoppingCart, AddShoppingCart, UpdateShoppingCart>, IShoppingCartService
    {
        IProductService _productService;

        public ShoppingCartService(DataContext context, IMapper mapper, IProductService productService) : base(context, mapper)
        {
            _productService = productService;
        }

        public override IQueryable<ShoppingCart> AddInclude(IQueryable<ShoppingCart> data)
        {
            data = data.Include(x => x.CartItems);
            return base.AddInclude(data);
        }

        public override IQueryable<ShoppingCart> AddFilter(IQueryable<ShoppingCart> data, SearchShoppingCart? search)
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

        public async override Task<DtoShoppingCart> GetById(int id)
        {
            var dbShoppingCart = await base.GetById(id);
            if (dbShoppingCart != null && dbShoppingCart.CartItems.IsNullOrEmpty())
                return dbShoppingCart;

            foreach (var item in dbShoppingCart.CartItems)
            {
                item.Product = await _productService.GetByIdWithChecks(dbShoppingCart.CustomerId, item.Product.Id);
            }

            return dbShoppingCart;
        }
    }
}
