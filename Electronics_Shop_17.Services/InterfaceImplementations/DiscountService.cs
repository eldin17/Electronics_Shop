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
    public class DiscountService : BaseServiceCRUD<DtoDiscount, Discount, SearchDiscount, AddDiscount, UpdateDiscount>, IDiscountService
    {
        public DiscountService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Discount> AddFilter(IQueryable<Discount> data, SearchDiscount? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.DiscountType))
            {
                data = data.Where(x => x.DiscountType.Contains(search.DiscountType));
            }
            if (search.Amount != null)
            {
                data = data.Where(x => x.Amount == search.Amount);
            }
            if (search.StartDate != null)
            {
                data = data.Where(x => x.StartDate >= search.StartDate);
            }
            if (search.EndDate != null)
            {
                data = data.Where(x => x.EndDate <= search.EndDate);
            }
            if (search.IsActive != null)
            {
                data = data.Where(x => x.IsActive == search.IsActive);
            }
            return base.AddFilter(data, search);
        }
    }
}
