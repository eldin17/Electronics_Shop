﻿using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Controllers
{
    [Route("api/[controller]")]
    //[Authorize]
    public class BaseController<T, TSearch> : ControllerBase where TSearch : class
    {
        protected IBaseService<T, TSearch> _service;

        public BaseController(IBaseService<T, TSearch> service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<Pagination<T>>> GetAll([FromQuery] TSearch? search = null)
        {
            return await _service.GetAll(search);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<T>> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
