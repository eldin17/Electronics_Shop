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
    public class ProductDiscountService : BaseServiceCRUD<DtoProductDiscount, ProductDiscount, SearchProductDiscount, AddProductDiscount, UpdateProductDiscount>, IProductDiscountService
    {
        public ProductDiscountService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<ProductDiscount> AddFilter(IQueryable<ProductDiscount> data, SearchProductDiscount? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (search.DiscountId != null)
            {
                data = data.Where(x => x.DiscountId == search.DiscountId);
            }
            return base.AddFilter(data, search);
        }
    }
}
