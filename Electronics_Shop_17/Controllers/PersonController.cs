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
    public class PersonController : BaseCRUDController<DtoPerson, SearchPerson, AddPerson, UpdatePerson>
    {
        public PersonController(IPersonService service) : base(service)
        {
        }
    }
}
