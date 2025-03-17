using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services
{
    public class Checks
    {
        public DataContext _context;
        public IMapper _mapper;
        public Checks(DataContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<DtoProduct> PriceCheck(int productId)
        {
            var product = await _context.Products.Include(x=>x.ProductDiscounts).FirstOrDefaultAsync(x=>x.Id== productId);
            if (product == null)
                throw new KeyNotFoundException($"Product with id {productId} doesn't exist"); 

            var dtoProduct = _mapper.Map<DtoProduct>(product);
            dtoProduct.FinalPrice= product.Price;

            var discounts = await _context.Discounts
                .Where(d => product.ProductDiscounts.Select(pd => pd.DiscountId).Contains(d.Id) &&
                    d.IsActive &&
                    DateTime.UtcNow >= d.StartDate &&
                    DateTime.UtcNow <= d.EndDate)
                    .ToListAsync();

            foreach (var discount in discounts) {                 
                    dtoProduct.FinalPrice-=discount.Amount;
                    if ((double)dtoProduct.FinalPrice < (double)product.Price * 0.6)
                        throw new InvalidOperationException("There has been a mistake with discounts for this product");
            }
            
            return dtoProduct;
        }

        public async Task<DtoOrderItem> StockCheck(OrderItem obj)
        {
            var productColor = await _context.ProductColors.SingleOrDefaultAsync(x => x.Id == obj.ProductColorId);
            if (productColor == null)
                throw new KeyNotFoundException($"Product color not found");

            var dtoObj = _mapper.Map<DtoOrderItem>(obj);

            if (productColor.Stock >= obj.Quantity)
                return dtoObj;
            else
            {
                dtoObj.Quantity = productColor.Stock;
                return dtoObj;
            }
        }

       
    }
}
