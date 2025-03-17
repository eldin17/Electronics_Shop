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
    public class CameraService : BaseServiceCRUD<DtoCamera, Camera, SearchCamera, AddCamera, UpdateCamera>, ICameraService
    {
        public CameraService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }        

        public override IQueryable<Camera> AddFilter(IQueryable<Camera> data, SearchCamera? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (search.Megapixels != null)
            {
                data = data.Where(x => x.Megapixels == search.Megapixels);
            }
            if (!string.IsNullOrWhiteSpace(search.SensorType))
            {
                data = data.Where(x => x.SensorType.Contains(search.SensorType));
            }
            if (!string.IsNullOrWhiteSpace(search.LensMount))
            {
                data = data.Where(x => x.LensMount.Contains(search.LensMount));
            }
            if (!string.IsNullOrWhiteSpace(search.VideoResolution))
            {
                data = data.Where(x => x.VideoResolution.Contains(search.VideoResolution));
            }
            if (search.Weight != null)
            {
                data = data.Where(x => x.Weight <= search.Weight);
            }
            if (search.Dimensions != null)
            {
                data = data.Where(x => x.Dimensions == search.Dimensions);
            }
            if (search.HasWiFi != null)
            {
                data = data.Where(x => x.HasWiFi == search.HasWiFi);
            }
            if (search.HasBluetooth != null)
            {
                data = data.Where(x => x.HasBluetooth == search.HasBluetooth);
            }
            if (!string.IsNullOrWhiteSpace(search.BatteryType))
            {
                data = data.Where(x => x.BatteryType.Contains(search.BatteryType));
            }
            if (search.BatteryLife != null)
            {
                data = data.Where(x => x.BatteryLife >= search.BatteryLife);
            }
            return base.AddFilter(data, search);
        }
    }
}
