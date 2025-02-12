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
    public class ShoppingCartService : BaseServiceCRUD<DtoShoppingCart, ShoppingCart, SearchShoppingCart, AddShoppingCart, UpdateShoppingCart>, IShoppingCartService
    {
        public ShoppingCartService(DataContext context, IMapper mapper) : base(context, mapper)
        {
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
    }
}
