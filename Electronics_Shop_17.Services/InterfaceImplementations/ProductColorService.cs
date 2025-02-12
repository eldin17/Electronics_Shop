using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class ProductColorService : BaseService<DtoProductColor, ProductColor, SearchProductColor>, IProductColorService
    {
        public ProductColorService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<ProductColor> AddInclude(IQueryable<ProductColor> data)
        {
            data = data.Include(x => x.ProductImages).ThenInclude(x => x.Image);
            return base.AddInclude(data);
        }

        public override IQueryable<ProductColor> AddFilter(IQueryable<ProductColor> data, SearchProductColor? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Name))
            {
                data = data.Where(x => x.Name.Contains(search.Name));
            }
            if (!string.IsNullOrWhiteSpace(search.HexCode))
            {
                data = data.Where(x => x.HexCode.Contains(search.HexCode));
            }
            if (search.Stock != null)
            {
                data = data.Where(x => x.Stock == search.Stock);
            }
            return base.AddFilter(data, search);
        }
    }
}
