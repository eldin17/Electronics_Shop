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
    public class DesktopPCService : BaseServiceCRUD<DtoDesktopPC, DesktopPC, SearchDesktopPC, AddDesktopPC, UpdateDesktopPC>,IDesktopPCService
    {
        public DesktopPCService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<DesktopPC> AddFilter(IQueryable<DesktopPC> data, SearchDesktopPC? search)
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
            if (search.RAM != null)
            {
                data = data.Where(x => x.RAM == search.RAM);
            }
            if (!string.IsNullOrWhiteSpace(search.StorageType))
            {
                data = data.Where(x => x.StorageType.Contains(search.StorageType));
            }
            if (search.StorageCapacity != null)
            {
                data = data.Where(x => x.StorageCapacity >= search.StorageCapacity);
            }
            if (!string.IsNullOrWhiteSpace(search.GraphicsCard))
            {
                data = data.Where(x => x.GraphicsCard.Contains(search.GraphicsCard));
            }
            if (!string.IsNullOrWhiteSpace(search.OperatingSystem))
            {
                data = data.Where(x => x.OperatingSystem.Contains(search.OperatingSystem));
            }
            if (!string.IsNullOrWhiteSpace(search.FormFactor))
            {
                data = data.Where(x => x.FormFactor.Contains(search.FormFactor));
            }
            if (search.Weight != null)
            {
                data = data.Where(x => x.Weight <= search.Weight);
            }
            if (!string.IsNullOrWhiteSpace(search.Dimensions))
            {
                data = data.Where(x => x.Dimensions.Contains(search.Dimensions));
            }
            if (search.USBPorts != null)
            {
                data = data.Where(x => x.USBPorts >= search.USBPorts);
            }
            if (search.HasWiFi != null)
            {
                data = data.Where(x => x.HasWiFi == search.HasWiFi);
            }
            if (search.HasBluetooth != null)
            {
                data = data.Where(x => x.HasBluetooth == search.HasBluetooth);
            }
            if (search.PowerSupplyWattage != null)
            {
                data = data.Where(x => x.PowerSupplyWattage >= search.PowerSupplyWattage);
            }
            if (!string.IsNullOrWhiteSpace(search.CoolingType))
            {
                data = data.Where(x => x.CoolingType.Contains(search.CoolingType));
            }
            if (search.HasRGBLighting != null)
            {
                data = data.Where(x => x.HasRGBLighting == search.HasRGBLighting);
            }
            return base.AddFilter(data, search);
        }
    }
}
