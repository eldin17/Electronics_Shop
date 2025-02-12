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
    public class TabletService : BaseServiceCRUD<DtoTablet, Tablet, SearchTablet, AddTablet, UpdateTablet>, ITabletService
    {
        public TabletService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Tablet> AddFilter(IQueryable<Tablet> data, SearchTablet? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
            }
            if (!string.IsNullOrEmpty(search.ScreenSize))
            {
                data = data.Where(x => x.ScreenSize == search.ScreenSize);
            }
            if (!string.IsNullOrEmpty(search.ScreenResolution))
            {
                data = data.Where(x => x.ScreenResolution == search.ScreenResolution);
            }
            if (!string.IsNullOrEmpty(search.ScreenType))
            {
                data = data.Where(x => x.ScreenType == search.ScreenType);
            }
            if (search.RefreshRate != null)
            {
                data = data.Where(x => x.RefreshRate == search.RefreshRate);
            }
            if (!string.IsNullOrEmpty(search.Processor))
            {
                data = data.Where(x => x.Processor == search.Processor);
            }
            if (search.RAM != null)
            {
                data = data.Where(x => x.RAM == search.RAM);
            }
            if (search.StorageCapacity != null)
            {
                data = data.Where(x => x.StorageCapacity == search.StorageCapacity);
            }
            if (search.SupportsExpandableStorage != null)
            {
                data = data.Where(x => x.SupportsExpandableStorage == search.SupportsExpandableStorage);
            }
            if (!string.IsNullOrEmpty(search.RearCameraResolution))
            {
                data = data.Where(x => x.RearCameraResolution == search.RearCameraResolution);
            }
            if (!string.IsNullOrEmpty(search.FrontCameraResolution))
            {
                data = data.Where(x => x.FrontCameraResolution == search.FrontCameraResolution);
            }
            if (search.BatteryCapacity != null)
            {
                data = data.Where(x => x.BatteryCapacity == search.BatteryCapacity);
            }
            if (search.EstimatedBatteryLife != null)
            {
                data = data.Where(x => x.EstimatedBatteryLife == search.EstimatedBatteryLife);
            }
            if (search.SupportsFastCharging != null)
            {
                data = data.Where(x => x.SupportsFastCharging == search.SupportsFastCharging);
            }
            if (search.SupportsWirelessCharging != null)
            {
                data = data.Where(x => x.SupportsWirelessCharging == search.SupportsWirelessCharging);
            }
            if (search.Supports5G != null)
            {
                data = data.Where(x => x.Supports5G == search.Supports5G);
            }
            if (search.HasWiFi6 != null)
            {
                data = data.Where(x => x.HasWiFi6 == search.HasWiFi6);
            }
            if (search.HasBluetooth != null)
            {
                data = data.Where(x => x.HasBluetooth == search.HasBluetooth);
            }
            if (search.HasCellular != null)
            {
                data = data.Where(x => x.HasCellular == search.HasCellular);
            }
            if (search.Weight != null)
            {
                data = data.Where(x => x.Weight == search.Weight);
            }
            if (!string.IsNullOrEmpty(search.Dimensions))
            {
                data = data.Where(x => x.Dimensions == search.Dimensions);
            }
            if (!string.IsNullOrEmpty(search.BuildMaterial))
            {
                data = data.Where(x => x.BuildMaterial == search.BuildMaterial);
            }
            if (!string.IsNullOrEmpty(search.OperatingSystem))
            {
                data = data.Where(x => x.OperatingSystem == search.OperatingSystem);
            }
            if (search.SupportsStylus != null)
            {
                data = data.Where(x => x.SupportsStylus == search.SupportsStylus);
            }
            if (search.HasFingerprintSensor != null)
            {
                data = data.Where(x => x.HasFingerprintSensor == search.HasFingerprintSensor);
            }
            if (search.HasFaceRecognition != null)
            {
                data = data.Where(x => x.HasFaceRecognition == search.HasFaceRecognition);
            }
            if (search.IsWaterResistant != null)
            {
                data = data.Where(x => x.IsWaterResistant == search.IsWaterResistant);
            }

            return base.AddFilter(data, search);
        }
    }
}
