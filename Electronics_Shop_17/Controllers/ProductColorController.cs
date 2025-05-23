﻿using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductColorController : BaseController<DtoProductColor, SearchProductColor>
    {
        public ProductColorController(IProductColorService service) : base(service)
        {
        }
    }
}
