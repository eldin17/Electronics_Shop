using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Services.Database;
using Microsoft.AspNetCore.Mvc.ModelBinding.Binders;
using Microsoft.AspNetCore.Routing.Constraints;
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

        public async Task<double> GetFinalPrice(int productId)
        {
            var product = await PriceCheck(productId);
            return product.FinalPrice;
        } 
        public async Task<DtoProduct> PriceCheck(DtoProduct product)
        {            
            product.FinalPrice= product.Price;

            var discounts = await _context.Discounts
                .Where(d => product.ProductDiscounts.Select(pd => pd.DiscountId).Contains(d.Id) &&
                    d.IsActive &&
                    DateTime.UtcNow >= d.StartDate &&
                    DateTime.UtcNow <= d.EndDate)
                    .ToListAsync();

            foreach (var discount in discounts) {
                product.FinalPrice-=discount.Amount;
                    if ((double)product.FinalPrice < (double)product.Price * 0.6)
                        throw new InvalidOperationException("There has been a mistake with discounts for this product");
            }
            
            return product;
        }

        public async Task<DtoProduct> PriceCheck(int productId)
        {
            var product = await _context.Products.Include(x => x.ProductDiscounts).FirstOrDefaultAsync(x => x.Id == productId);
            if (product == null)
                throw new KeyNotFoundException($"Product with id {productId} doesn't exist");

            var dtoProduct = _mapper.Map<DtoProduct>(product);
            dtoProduct.FinalPrice = product.Price;

            return await PriceCheck(dtoProduct);
        }


        public async Task<double> ReviewCheck(DtoProduct product)
        {
            var ratings = await _context.Reviews
                .Where(r => r.ProductId == product.Id)
                .Select(r => r.Rating)
                .ToListAsync(); 

            return ratings.Any() ? ratings.Average() : 0; 
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
