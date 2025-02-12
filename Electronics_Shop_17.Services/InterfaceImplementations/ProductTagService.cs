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
    public class ProductTagService : BaseServiceCRUD<DtoProductTag, ProductTag, SearchProductTag, AddProductTag, UpdateProductTag>, IProductTagService
    {
        public ProductTagService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }


        public override IQueryable<ProductTag> AddFilter(IQueryable<ProductTag> data, SearchProductTag? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Tag))
            {
                data = data.Where(x => x.Tag.Contains(search.Tag));
            }
            return base.AddFilter(data, search);
        }
    }
}
