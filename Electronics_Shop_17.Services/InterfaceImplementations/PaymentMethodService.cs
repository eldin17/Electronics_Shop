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
    public class PaymentMethodService : BaseServiceCRUD<DtoPaymentMethod, PaymentMethod, SearchPaymentMethod, AddPaymentMethod, UpdatePaymentMethod>, IPaymentMethodService
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
            if (!string.IsNullOrWhiteSpace(search.Code))
            {
                data = data.Where(x => x.Code.Contains(search.Code));
            }
            if (!string.IsNullOrWhiteSpace(search.Type))
            {
                data = data.Where(x => x.Type.Contains(search.Type));
            }
            if (!string.IsNullOrWhiteSpace(search.Provider))
            {
                data = data.Where(x => x.Provider.Contains(search.Provider));
            }            
            return base.AddFilter(data, search);
        }
    }
}
