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
    public class ProductProductTagService : BaseServiceCRUD<DtoProductProductTag, ProductProductTag, SearchProductProductTag, AddProductProductTag, UpdateProductProductTag>, IProductProductTagService
    {
        public ProductProductTagService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<ProductProductTag> AddInclude(IQueryable<ProductProductTag> data)
        {
            data = data.Include(x => x.ProductTag);
            return base.AddInclude(data);
        }

        public override IQueryable<ProductProductTag> AddFilter(IQueryable<ProductProductTag> data, SearchProductProductTag? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (search.ProductTagId != null)
            {
                data = data.Where(x => x.ProductTagId == search.ProductTagId);
            }
            return base.AddFilter(data, search);
        }
    }
}
