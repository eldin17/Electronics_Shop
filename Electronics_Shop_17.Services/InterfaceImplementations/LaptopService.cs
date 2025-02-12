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
    public class LaptopService : BaseServiceCRUD<DtoLaptop, Laptop, SearchLaptop, AddLaptop, UpdateLaptop>, ILaptopService
    {
        public LaptopService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Laptop> AddFilter(IQueryable<Laptop> data, SearchLaptop? search)
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
            if (!string.IsNullOrWhiteSpace(search.ScreenSize))
            {
                data = data.Where(x => x.ScreenSize.Contains(search.ScreenSize));
            }
            if (!string.IsNullOrWhiteSpace(search.ScreenResolution))
            {
                data = data.Where(x => x.ScreenResolution.Contains(search.ScreenResolution));
            }
            if (!string.IsNullOrWhiteSpace(search.ScreenType))
            {
                data = data.Where(x => x.ScreenType.Contains(search.ScreenType));
            }
            if (search.BatteryCapacity != null)
            {
                data = data.Where(x => x.BatteryCapacity >= search.BatteryCapacity);
            }
            if (search.BatteryLife != null)
            {
                data = data.Where(x => x.BatteryLife >= search.BatteryLife);
            }
            if (search.HasWiFi != null)
            {
                data = data.Where(x => x.HasWiFi == search.HasWiFi);
            }
            if (search.HasBluetooth != null)
            {
                data = data.Where(x => x.HasBluetooth == search.HasBluetooth);
            }
            if (search.USBPorts != null)
            {
                data = data.Where(x => x.USBPorts >= search.USBPorts);
            }
            if (search.HasEthernetPort != null)
            {
                data = data.Where(x => x.HasEthernetPort == search.HasEthernetPort);
            }
            if (search.HasHDMI != null)
            {
                data = data.Where(x => x.HasHDMI == search.HasHDMI);
            }
            if (search.HasThunderbolt != null)
            {
                data = data.Where(x => x.HasThunderbolt == search.HasThunderbolt);
            }
            if (search.Weight != null)
            {
                data = data.Where(x => x.Weight <= search.Weight);
            }
            if (!string.IsNullOrWhiteSpace(search.Dimensions))
            {
                data = data.Where(x => x.Dimensions.Contains(search.Dimensions));
            }
            if (!string.IsNullOrWhiteSpace(search.BuildMaterial))
            {
                data = data.Where(x => x.BuildMaterial.Contains(search.BuildMaterial));
            }
            if (search.HasBacklitKeyboard != null)
            {
                data = data.Where(x => x.HasBacklitKeyboard == search.HasBacklitKeyboard);
            }
            if (search.HasFingerprintReader != null)
            {
                data = data.Where(x => x.HasFingerprintReader == search.HasFingerprintReader);
            }
            if (search.HasWebcam != null)
            {
                data = data.Where(x => x.HasWebcam == search.HasWebcam);
            }
            if (!string.IsNullOrWhiteSpace(search.OperatingSystem))
            {
                data = data.Where(x => x.OperatingSystem.Contains(search.OperatingSystem));
            }

            return base.AddFilter(data, search);
        }
    }
}
