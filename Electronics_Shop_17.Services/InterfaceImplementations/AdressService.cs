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

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class AdressService : BaseServiceSoftDelete<DtoAdress, Adress, SearchAdress, AddAdress, UpdateAdress>, IAdressService
    {
        public AdressService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Adress> AddFilter(IQueryable<Adress> data, SearchAdress? search)
        {
            if(search.Id != null)
            {
                data = data.Where(x=>x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Street))
            {
                data = data.Where(x => x.Street.Contains(search.Street));
            }
            if (!string.IsNullOrWhiteSpace(search.City))
            {
                data = data.Where(x => x.City.Contains(search.City));
            }
            if (!string.IsNullOrWhiteSpace(search.Country))
            {
                data = data.Where(x => x.Country.Contains(search.Country));
            }
            if (!string.IsNullOrWhiteSpace(search.PostalCode))
            {
                data = data.Where(x => x.PostalCode.Contains(search.PostalCode));
            }
            if (search.PersonId != null)
            {
                data = data.Where(x => x.PersonId == search.PersonId);
            }
            if (search.isDeleted != null)
            {
                data = data.Where(x => x.isDeleted == search.isDeleted);
            }
            return base.AddFilter(data, search);
        }
    }
}
