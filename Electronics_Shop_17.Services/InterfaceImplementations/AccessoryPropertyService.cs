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

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class AccessoryPropertyService : BaseServiceCRUD<DtoAccessoryProperty, AccessoryProperty, SearchAccessoryProperty, AddAccessoryProperty, UpdateAccessoryProperty>, IAccessoryPropertyService
    {
        public AccessoryPropertyService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }        

        public override IQueryable<AccessoryProperty> AddFilter(IQueryable<AccessoryProperty> data, SearchAccessoryProperty? search)
        {
            if(search.Id != null)
            {
                data=data.Where(x=>x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.PropertyName))
            {
                data = data.Where(x => x.PropertyName.Contains(search.PropertyName));
            }
            if (search.AccessoryId != null)
            {
                data = data.Where(x => x.AccessoryId == search.AccessoryId);
            }
            return base.AddFilter(data, search);

        }

        //public async Task<DtoAccessoryProperty> AddTest(AddAccessoryProperty addRequest,int? accessoryId)
        //{
        //    var finalAccessoryId = addRequest.AccessoryId != 0 ? addRequest.AccessoryId : accessoryId;

        //    if (finalAccessoryId == null || finalAccessoryId == 0)
        //        throw new ArgumentException("AccessoryId must be provided either in the model or as a parameter.");

        //    addRequest.AccessoryId = finalAccessoryId;
        //    var accessoryProperty = _mapper.Map<AccessoryProperty>(addRequest);

        //    _context.AccessoryProperties.Add(accessoryProperty);
        //    await _context.SaveChangesAsync();

        //    return _mapper.Map<DtoAccessoryProperty>(accessoryProperty);
        //}


    }
}
