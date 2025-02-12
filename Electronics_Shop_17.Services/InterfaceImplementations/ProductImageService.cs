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
    public class ProductImageService : BaseService<DtoProductImage, ProductImage, SearchProductImage>, IProductImageService
    {
        public ProductImageService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<ProductImage> AddInclude(IQueryable<ProductImage> data)
        {
            data = data.Include(x => x.Image).Include(x => x.ProductColor);
            return base.AddInclude(data);
        }

        public override IQueryable<ProductImage> AddFilter(IQueryable<ProductImage> data, SearchProductImage? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ImageId != null)
            {
                data = data.Where(x => x.ImageId == search.ImageId);
            }
            return base.AddFilter(data, search);
        }
    }
}
