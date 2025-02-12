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
    }
}
