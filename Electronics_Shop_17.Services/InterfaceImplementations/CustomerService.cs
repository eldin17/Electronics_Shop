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
    public class CustomerService : BaseServiceSoftDelete<DtoCustomer, Customer, SearchCustomer, AddCustomer, UpdateCustomer>, ICustomerService
    {
        public CustomerService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Customer> AddInclude(IQueryable<Customer> data)
        {
            data = data.Include(x => x.UserAccount).ThenInclude(x=>x.Image).Include(x => x.Adresses).Include(x => x.Wishlist).Include(x => x.PaymentMethods).Include(x => x.Person);
            return base.AddInclude(data);
        }


        public override IQueryable<Customer> AddFilter(IQueryable<Customer> data, SearchCustomer? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.LoyaltyPoints != null)
            {
                data = data.Where(x => x.LoyaltyPoints == search.LoyaltyPoints);
            }
            if (search.MinLoyaltyPoints != null)
            {
                data = data.Where(x => x.LoyaltyPoints >= search.MinLoyaltyPoints);
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
