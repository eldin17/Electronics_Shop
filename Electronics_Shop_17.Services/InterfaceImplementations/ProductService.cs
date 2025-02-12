﻿using System;
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
using Microsoft.IdentityModel.Tokens;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class ProductService : BaseServiceSoftDelete<DtoProduct, Product, SearchProduct, AddProduct, UpdateProduct>, IProductService
    {
        public ProductService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Product> AddInclude(IQueryable<Product> data)
        {
            data = data.Include(x => x.ProductCategory)
                .Include(x => x.ProductImages).ThenInclude(x => x.Image)
                .Include(x => x.ProductColors)
                .Include(x => x.ProductProductTags)
                .Include(x => x.Reviews)
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
            if (search.AllColorsStock != null)
            {
                data = data.Where(x => x.AllColorsStock >= search.AllColorsStock);
            }
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
    }
}
