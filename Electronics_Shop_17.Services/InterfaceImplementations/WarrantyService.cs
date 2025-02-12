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
    public class WarrantyService : BaseServiceCRUD<DtoWarranty, Warranty, SearchWarranty, AddWarranty, UpdateWarranty>, IWarrantyService
    {
        public WarrantyService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }


        public override IQueryable<Warranty> AddFilter(IQueryable<Warranty> data, SearchWarranty? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.Period_mm != null)
            {
                data = data.Where(x => x.Period_mm == search.Period_mm);
            }
            if (!string.IsNullOrWhiteSpace(search.CoverageDetails))
            {
                data = data.Where(x => x.CoverageDetails.Contains(search.CoverageDetails));
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            return base.AddFilter(data, search);
        }
    }
}
