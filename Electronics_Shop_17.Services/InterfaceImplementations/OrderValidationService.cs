using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Helpers;
using Electronics_Shop_17.Services.Interfaces;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class OrderValidationService : IOrderValidationService
    {
        private readonly Checks _checks;

        public OrderValidationService(Checks checks)
        {
            _checks = checks;
        }
        public async Task<OrderValidationResult> ValidateAsync(Order order)
        {
            bool hasChanges = false;            
            var correctedItems = new List<OrderItem>();

            double orderTotalCheck = 0;
            double orderFinalTotalCheck = 0;

            foreach (var item in order.OrderItems)
            {
                var stockChecked = await _checks.StockCheck(item);
                var priceChecked = await _checks.PriceCheck(item.ProductId);

                if (item.Quantity != stockChecked.Quantity ||
                    item.FinalPrice != priceChecked.FinalPrice)
                {
                    hasChanges = true;

                    item.Quantity = stockChecked.Quantity;
                    item.FinalPrice = priceChecked.FinalPrice;
                }

                orderFinalTotalCheck += item.FinalPrice;
                orderTotalCheck += item.Price;
                correctedItems.Add(item);
            }

            return new OrderValidationResult
            {
                HasChanges = hasChanges,
                TotalAmount = orderTotalCheck,
                FinalTotalAmount = orderFinalTotalCheck,
                CorrectedItems = correctedItems
            };
        }
    }
}
