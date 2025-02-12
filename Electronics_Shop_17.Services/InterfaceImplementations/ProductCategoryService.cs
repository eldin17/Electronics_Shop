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
    public class ProductCategoryService : BaseServiceSoftDelete<DtoProductCategory, ProductCategory, SearchProductCategory, AddProductCategory, UpdateProductCategory>, IProductCategoryService
    {
        public ProductCategoryService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }        

        public override IQueryable<ProductCategory> AddFilter(IQueryable<ProductCategory> data, SearchProductCategory? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Name))
            {
                data = data.Where(x => x.Name.Contains(search.Name));
            }
            return base.AddFilter(data, search);
        }
    }
}
