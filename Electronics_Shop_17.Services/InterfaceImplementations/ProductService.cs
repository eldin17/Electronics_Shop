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
using Electronics_Shop_17.Services.ProductStateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class ProductService : BaseServiceSoftDelete<DtoProduct, Product, SearchProduct, AddProduct, UpdateProduct>, IProductService
    {
        BaseProductState _baseProductState;
        Checks _checks;

        public ProductService(DataContext context, IMapper mapper, BaseProductState baseProductState, Checks checks) : base(context, mapper)
        {
            _baseProductState = baseProductState;
            _checks = checks;
        }

        public override async Task<Pagination<DtoProduct>> GetAll(SearchProduct? search = null)
        {
            var products = await base.GetAll(search);
            if (products.Data == null || !products.Data.Any())
            {
                return products;
            }

            var productIds = products.Data.Select(p => p.Id).ToList();

            var discounts = await _context.Discounts
                .Where(d => d.IsActive &&
                            DateTime.UtcNow >= d.StartDate &&
                            DateTime.UtcNow <= d.EndDate &&
                            d.ProductDiscounts.Any(pd => productIds.Contains(pd.ProductId)))
                .Include(d => d.ProductDiscounts)
                .ToListAsync();

            var averageRatings = await _context.Reviews
                .Where(r => productIds.Contains(r.ProductId))
                .GroupBy(r => r.ProductId)
                .Select(g => new { ProductId = g.Key, AverageRating = g.Average(r => r.Rating) })
                .ToDictionaryAsync(x => x.ProductId, x => x.AverageRating);

            foreach (var item in products.Data)
            {
                item.reviewScoreAvg = averageRatings.TryGetValue(item.Id, out var avg) ? avg : 0;

                item.FinalPrice = item.Price;

                var productDiscountIds = item.ProductDiscounts.Select(pd => pd.DiscountId).ToList();
                var relevantDiscounts = discounts.Where(d => productDiscountIds.Contains(d.Id));

                foreach (var discount in relevantDiscounts)
                {
                    item.FinalPrice -= discount.Amount;
                    if ((double)item.FinalPrice < (double)item.Price * 0.6)
                    {
                        throw new InvalidOperationException("There has been a mistake with discounts for this product");
                    }
                }
            }

            return products;
        }

        public async Task<Pagination<DtoProduct>> GetAllWithChecks(int customerId, SearchProduct search = null)
        {
            var customer = await _context.Customers.Include(x=>x.Wishlist).FirstOrDefaultAsync(x=>x.Id==customerId);
            if(customer!=null && customer.Wishlist != null && customer.Wishlist.WishlistItems.Any())
            {
                var wishlist = customer.Wishlist.WishlistItems.Select(x=>x.ProductId).ToList();
                var products = await GetAll(search);
                foreach (var item in products.Data)
                {
                    if (wishlist.Contains(item.Id))
                        item.isFavourite = true;
                    else 
                        item.isFavourite = false;
                }
                return products;
            }
            return await GetAll(search);
        }
        public async Task<Pagination<DtoProduct>> GetAllWithChecksByUserAccId(int userAccId, SearchProduct search = null)
        {
            var customer = await _context.Customers.FirstOrDefaultAsync(x=>x.UserAccountId==userAccId);
            return await GetAllWithChecks(customer.Id, search);
        }


        public override async Task<DtoProduct> GetById(int id)
        {
            var product = await base.GetById(id);

            var priceCheckedObj = await _checks.PriceCheck(product);
            product.FinalPrice = priceCheckedObj.FinalPrice;
            product.reviewScoreAvg = await _checks.ReviewCheck(product);

            return product;
        }

        public async Task<DtoProduct> GetByIdWithChecks(int customerId, int id)
        {
            var customer = await _context.Customers.Include(x => x.Wishlist).FirstOrDefaultAsync(x => x.Id == customerId);
            if (customer != null && customer.Wishlist != null && customer.Wishlist.WishlistItems.Any())
            {
                var wishlist = customer.Wishlist.WishlistItems.Select(x => x.ProductId).ToList();
                var product = await GetById(id);
                if (wishlist.Contains(product.Id))
                    product.isFavourite = true;
                else
                    product.isFavourite = false;
                return product;
            }
            return await GetById(id); 
        }

        public override IQueryable<Product> AddInclude(IQueryable<Product> data)
        {
            data = data.Include(x => x.ProductCategory)
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
                .Include(x => x.ProductColors)
                .Include(x => x.ProductProductTags)
                //.Include(x => x.Reviews)
                .Include(x => x.Warranty);

            return base.AddInclude(data);
        }

        public override IQueryable<Product> AddInclude2(IQueryable<Product> data, int id)
        {
            //var obj = _context.Products
            //    .Include(x => x.ProductCategory)                
            //    .FirstOrDefault(x=> x.Id == id);

            var obj = data.Include(x => x.ProductCategory).FirstOrDefault(data => data.Id == id);

            switch (obj.ProductCategory.Name)
            {
                case "Camera":
                    data = data.Include(x => x.Camera);
                    break;
                case "DesktopPC":
                    data = data.Include(x => x.DesktopPC);
                    break;
                case "GamingConsole":
                    data = data.Include(x => x.GamingConsole);
                    break;
                case "Laptop":
                    data = data.Include(x => x.Laptop);
                    break;
                case "Phone":
                    data = data.Include(x => x.Phone);
                    break;
                case "Tablet":
                    data = data.Include(x => x.Tablet);
                    break;
                case "Television":
                    data = data.Include(x => x.Television);
                    break;
                case "Accessory":
                    data = data.Include(x => x.Accessory).ThenInclude(x=>x.AccessoryCategory)
                        .Include(x => x.Accessory).ThenInclude(x => x.AccessoryProperties);
                    break;
                default:
                    break;
            }
            return base.AddInclude2(data,id);
        }

        public override IQueryable<Product> AddFilter(IQueryable<Product> data, SearchProduct? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.FullTextSearch))
            {
                data = data.Where(x => x.Brand.Contains(search.FullTextSearch) ||
                x.Model.Contains(search.FullTextSearch) ||
                x.Description.Contains(search.FullTextSearch));
            }
            if (!string.IsNullOrWhiteSpace(search.FullTextCategorySearch))
            {
                data = data.Where(x => search.FullTextCategorySearch.Contains(x.ProductCategory.Name));
            }
            if (!string.IsNullOrWhiteSpace(search.Brand))
            {
                data = data.Where(x => x.Brand.Contains(search.Brand));
            }
            if (!string.IsNullOrWhiteSpace(search.Model))
            {
                data = data.Where(x => x.Model.Contains(search.Model));
            }
            if (!string.IsNullOrWhiteSpace(search.Description))
            {
                data = data.Where(x => x.Description.Contains(search.Description));
            }
            if (search.PriceLow != null)
            {
                data = data.Where(x => x.Price >= search.PriceLow);
            }
            if (search.PriceHigh != null)
            {
                data = data.Where(x => x.Price <= search.PriceHigh);
            }
            //if (search.AllColorsStock != null)
            //{
            //    data = data.Where(x => x.AllColorsStock >= search.AllColorsStock);
            //}
            if (search.ProductCategoryId != null)
            {
                data = data.Where(x => x.ProductCategoryId == search.ProductCategoryId);
            }
            if (!search.ProductProductTags.IsNullOrEmpty())
            {
                data = data.Where(x => x.ProductProductTags
                    .Any(pt => search.ProductProductTags.Contains(pt.Id)));
            }



            return base.AddFilter(data, search);
        }

        public override async Task<DtoProduct> Add(AddProduct addRequest)
        {
            var state = _baseProductState.GetState(addRequest.StateMachine);
            return await state.Add(addRequest);
        }
        

        public override async Task<DtoProduct> Update(int id, UpdateProduct updateRequest)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.Update(id, updateRequest);
        }

        public override async Task<DtoProduct> Delete(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.Delete(id);
        }

        public async Task<List<string>> AllowedActionsInState(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.AllowedActionsInState();
        }

        public async Task<DtoProduct> Activate(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.Activate(id);
        }

        public override async Task<DtoProduct> SoftDelete(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.SoftDelete(id);
        }

        public async Task<DtoProduct> CheckStock(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.CheckStock(id);
        }
        public async Task<DtoProduct> Restock(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.Restock(id);
        }
        public async Task<DtoProduct> Restore(int id)
        {
            var obj = await _context.Products.FindAsync(id);
            var state = _baseProductState.GetState(obj.StateMachine);
            return await state.Restore(id);
        }

        public async Task<List<DtoProduct>> GetProductsByIdsAsync(List<int> ids)
        {
            if (ids == null || !ids.Any())
            {
                return new List<DtoProduct>();
            }

            var dbObj = await _context.Products
                .Where(p => ids.Contains(p.Id)).Where(p=>!p.isDeleted && p.StateMachine=="Active")
                .ToListAsync();

            return _mapper.Map<List<DtoProduct>>(dbObj);
        }
    }
}
