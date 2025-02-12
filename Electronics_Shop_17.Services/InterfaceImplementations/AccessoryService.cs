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

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class AccessoryService : BaseServiceCRUD<DtoAccessory, Accessory, SearchAccessory, AddAccessory, UpdateAccessory>, IAccessoryService
    {
        //protected IAccessoryPropertyService _accessoryPropertyService;
        public AccessoryService(DataContext context, IMapper mapper/*, IAccessoryPropertyService accessoryPropertyService*/) : base(context, mapper)
        {
            //_accessoryPropertyService = accessoryPropertyService;
        }

        public override IQueryable<Accessory> AddInclude(IQueryable<Accessory> data)
        {
            data = data.Include(x => x.AccessoryCategory).Include(x => x.AccessoryProperties);
            return base.AddInclude(data);
        }


        public override IQueryable<Accessory> AddFilter(IQueryable<Accessory> data, SearchAccessory? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Name))
            {
                data = data.Where(x => x.Name.Contains(search.Name));
            }
            if (!string.IsNullOrWhiteSpace(search.Description))
            {
                data = data.Where(x => x.Description.Contains(search.Description));
            }
            if (search.AccessoryCategoryId != null)
            {
                data = data.Where(x => x.AccessoryCategoryId == search.AccessoryCategoryId);
            }
            return base.AddFilter(data, search);
        }

        

    }
}
