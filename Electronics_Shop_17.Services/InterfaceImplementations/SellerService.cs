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
    public class SellerService : BaseServiceSoftDelete<DtoSeller, Seller, SearchSeller, AddSeller, UpdateSeller>, ISellerService
    {
        public SellerService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Seller> AddInclude(IQueryable<Seller> data)
        {
            data = data.Include(x => x.Adress).Include(x => x.UserAccount).Include(x => x.Person);
            return base.AddInclude(data);
        }

       
        public override IQueryable<Seller> AddFilter(IQueryable<Seller> data, SearchSeller? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.StoreName))
            {
                data = data.Where(x => x.StoreName.Contains(search.StoreName));
            }
            if (search.LicenseNumber != null)
            {
                data = data.Where(x => x.LicenseNumber == search.LicenseNumber);
            }
            if (search.AdressId != null)
            {
                data = data.Where(x => x.AdressId == search.AdressId);
            }
            if (search.UserAccountId != null)
            {
                data = data.Where(x => x.UserAccountId == search.UserAccountId);
            }
            if (search.PersonId != null)
            {
                data = data.Where(x => x.PersonId == search.PersonId);
            }
            return base.AddFilter(data, search);
        }
    }
}
