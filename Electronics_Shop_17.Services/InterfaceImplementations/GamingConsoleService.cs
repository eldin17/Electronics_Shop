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
    public class GamingConsoleService : BaseServiceCRUD<DtoGamingConsole, GamingConsole, SearchGamingConsole, AddGamingConsole, UpdateGamingConsole>,IGamingConsoleService
    {
        public GamingConsoleService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<GamingConsole> AddFilter(IQueryable<GamingConsole> data, SearchGamingConsole? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (!string.IsNullOrWhiteSpace(search.Processor))
            {
                data = data.Where(x => x.Processor.Contains(search.Processor));
            }
            if (!string.IsNullOrWhiteSpace(search.GraphicsProcessor))
            {
                data = data.Where(x => x.GraphicsProcessor.Contains(search.GraphicsProcessor));
            }
            if (search.Ram != null)
            {
                data = data.Where(x => x.Ram == search.Ram);
            }
            if (!string.IsNullOrWhiteSpace(search.StorageType))
            {
                data = data.Where(x => x.StorageType.Contains(search.StorageType));
            }
            if (search.StorageCapacity != null)
            {
                data = data.Where(x => x.StorageCapacity >= search.StorageCapacity);
            }
            if (!string.IsNullOrWhiteSpace(search.MaxResolution))
            {
                data = data.Where(x => x.MaxResolution.Contains(search.MaxResolution));
            }
            if (search.MaxFPS != null)
            {
                data = data.Where(x => x.MaxFPS >= search.MaxFPS);
            }
            if (search.UsbPorts != null)
            {
                data = data.Where(x => x.UsbPorts >= search.UsbPorts);
            }
            if (search.HasWiFi != null)
            {
                data = data.Where(x => x.HasWiFi == search.HasWiFi);
            }
            if (search.HasBluetooth != null)
            {
                data = data.Where(x => x.HasBluetooth == search.HasBluetooth);
            }
            if (search.HasEthernetPort != null)
            {
                data = data.Where(x => x.HasEthernetPort == search.HasEthernetPort);
            }
            if (search.SupportsExternalStorage != null)
            {
                data = data.Where(x => x.SupportsExternalStorage == search.SupportsExternalStorage);
            }
            if (search.SupportsVR != null)
            {
                data = data.Where(x => x.SupportsVR == search.SupportsVR);
            }
            if (search.HasPhysicalMediaDrive != null)
            {
                data = data.Where(x => x.HasPhysicalMediaDrive == search.HasPhysicalMediaDrive);
            }
            if (search.IsPortable != null)
            {
                data = data.Where(x => x.IsPortable == search.IsPortable);
            }
            if (!string.IsNullOrWhiteSpace(search.ControllerType))
            {
                data = data.Where(x => x.ControllerType.Contains(search.ControllerType));
            }
            if (search.SupportsBackwardCompatibility != null)
            {
                data = data.Where(x => x.SupportsBackwardCompatibility == search.SupportsBackwardCompatibility);
            }
            if (!string.IsNullOrWhiteSpace(search.OnlineService))
            {
                data = data.Where(x => x.OnlineService.Contains(search.OnlineService));
            }
            if (search.Weight != null)
            {
                data = data.Where(x => x.Weight <= search.Weight);
            }
            if (!string.IsNullOrWhiteSpace(search.Dimensions))
            {
                data = data.Where(x => x.Dimensions.Contains(search.Dimensions));
            }       
            return base.AddFilter(data, search);
        }
    }
}
