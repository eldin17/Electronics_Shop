using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Helpers;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface IOrderValidationService
    {
        Task<OrderValidationResult> ValidateAsync(Order order);
    }
}
