﻿using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : BaseSoftDeleteController<DtoProduct, SearchProduct, AddProduct, UpdateProduct>
    {
        public ProductController(IProductService service) : base(service)
        {
        }

        [HttpPatch("Activate/{id}")]
        public virtual async Task<DtoProduct> Activate(int id)
        {
            return await (_service as IProductService).Activate(id);
        }

        [HttpPatch("CheckStock/{id}")]
        public virtual async Task<DtoProduct> CheckStock(int id)
        {
            return await (_service as IProductService).CheckStock(id);
        }
        [HttpPatch("Restock/{id}")]
        public virtual async Task<DtoProduct> Restock(int id)
        {
            return await (_service as IProductService).Restock(id);
        }
        [HttpPatch("Restore/{id}")]
        public virtual async Task<DtoProduct> Restore(int id)
        {
            return await (_service as IProductService).Restore(id);
        }
    }
}
