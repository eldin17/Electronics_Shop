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
using Microsoft.Identity.Client;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class DiscountService : BaseServiceCRUD<DtoDiscount, Discount, SearchDiscount, AddDiscount, UpdateDiscount>, IDiscountService
    {
        IProductDiscountService _productDiscountService;
        public DiscountService(DataContext context, IMapper mapper, IProductDiscountService productDiscountService) : base(context, mapper)
        {
            _productDiscountService = productDiscountService;
        }

        public override IQueryable<Discount> AddFilter(IQueryable<Discount> data, SearchDiscount? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.DiscountType))
            {
                data = data.Where(x => x.DiscountType.Contains(search.DiscountType));
            }
            if (search.Amount != null)
            {
                data = data.Where(x => x.Amount == search.Amount);
            }
            if (search.StartDate != null)
            {
                data = data.Where(x => x.StartDate >= search.StartDate);
            }
            if (search.EndDate != null)
            {
                data = data.Where(x => x.EndDate <= search.EndDate);
            }
            if (search.IsActive != null)
            {
                data = data.Where(x => x.IsActive == search.IsActive);
            }
            return base.AddFilter(data, search);
        }

        public override async Task<DtoDiscount> Add(AddDiscount addRequest)
        {

            var data = await base.Add(addRequest);
            var appliedList = new List<AddProductDiscount>();


            var products = await _context.Products.Where(pr => addRequest.ProductDiscounts.Select(x => x.ProductId).Contains(pr.Id)).ToListAsync();
            foreach (var product in products)
            {
                var productDiscounts = _context.ProductDiscounts.Where(x => x.ProductId == product.Id);

                var allDiscounts = await _context.Discounts.Where(d => productDiscounts.Select(x => x.ProductId).Contains(product.Id))
                .Where(d => d.IsActive &&
                    DateTime.UtcNow >= d.StartDate &&
                    DateTime.UtcNow <= d.EndDate)
                .ToListAsync();               

                var priceCheck = product.Price;

                foreach (var discount in allDiscounts)
                {
                    priceCheck -= discount.Amount;
                    
                    if (priceCheck < ((double)0.6 * product.Price))
                    {
                        priceCheck += discount.Amount;
                        if (discount.Id==data.Id)
                            data.NotAppliedList.Add(_mapper.Map<DtoProduct>(product));
                    }
                    else 
                    {
                        if(discount.Id==data.Id)
                        {    
                            var obj = new AddProductDiscount()
                            {
                                ProductId = product.Id,
                                DiscountId = discount.Id,
                            };
                            appliedList.Add(obj);
                        }
                    }
                    
                }
            }
            var newProductDiscounts = _mapper.Map<List<ProductDiscount>>(appliedList);
            _context.ProductDiscounts.AddRange(newProductDiscounts);  

            await _context.SaveChangesAsync();

            var returnDbObj = await _context.Discounts.FindAsync(data.Id);
            var returnDtoObj = _mapper.Map<DtoDiscount>(returnDbObj);
            returnDtoObj.NotAppliedList = data.NotAppliedList;
            return returnDtoObj;
        }

    }

}
