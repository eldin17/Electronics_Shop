using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class PaymentMethodService : BaseServiceSoftDelete<DtoPaymentMethod, PaymentMethod, SearchPaymentMethod, AddPaymentMethod, UpdatePaymentMethod>, IPaymentMethodService
    {
        public PaymentMethodService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<PaymentMethod> AddFilter(IQueryable<PaymentMethod> data, SearchPaymentMethod? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Type))
            {
                data = data.Where(x => x.Type.Contains(search.Type));
            }
            if (!string.IsNullOrWhiteSpace(search.Provider))
            {
                data = data.Where(x => x.Provider.Contains(search.Provider));
            }
            if (!string.IsNullOrWhiteSpace(search.Key))
            {
                data = data.Where(x => x.Key.Contains(search.Key));
            }
            if (search.ExpiryDate != null)
            {
                data = data.Where(x => x.ExpiryDate <= search.ExpiryDate);
            }
            if (search.IsDefault != null)
            {
                data = data.Where(x => x.IsDefault == search.IsDefault);
            }
            if (search.CustomerId != null)
            {
                data = data.Where(x => x.CustomerId == search.CustomerId);
            }
            if (search.isDeleted != null)
            {
                data = data.Where(x => x.isDeleted == search.isDeleted);
            }
            return base.AddFilter(data, search);
        }

        public override async Task<DtoPaymentMethod> Add(AddPaymentMethod addRequest)
        {
            var dbobj = await _context.PaymentMethods.FirstOrDefaultAsync(x => x.CustomerId == addRequest.CustomerId && x.Type == addRequest.Type);
            if(dbobj != null)
            {
                dbobj.isDeleted = false;
                await _context.SaveChangesAsync();
                return _mapper.Map<DtoPaymentMethod>(dbobj);
            }
            return await base.Add(addRequest);
        }

        public async Task<DtoPaymentMethod> FindAndDelete(PayMethDel obj)
        {
            if (obj != null)
            {
                var dbobj = await _context.PaymentMethods.FirstOrDefaultAsync(x=>x.CustomerId == obj.CustomerId && x.Type == obj.Type);
                if (obj!=null)
                {
                        dbobj.isDeleted = true;
                    await _context.SaveChangesAsync();
                    return _mapper.Map<DtoPaymentMethod>(dbobj);
                }
            }
            return new DtoPaymentMethod();
        }
    }
}
