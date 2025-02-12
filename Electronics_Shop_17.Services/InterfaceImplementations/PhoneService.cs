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
    public class PhoneService : BaseServiceCRUD<DtoPhone, Phone, SearchPhone, AddPhone, UpdatePhone>, IPhoneService
    {
        public PhoneService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Phone> AddFilter(IQueryable<Phone> data, SearchPhone? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.ProductId != null)
            {
                data = data.Where(x => x.ProductId == search.ProductId);
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
            if (search.RefreshRate != null)
            {
                data = data.Where(x => x.RefreshRate >= search.RefreshRate);
            }
            if (!string.IsNullOrWhiteSpace(search.Processor))
            {
                data = data.Where(x => x.Processor.Contains(search.Processor));
            }
            if (search.RAM != null)
            {
                data = data.Where(x => x.RAM >= search.RAM);
            }
            if (search.StorageCapacity != null)
            {
                data = data.Where(x => x.StorageCapacity >= search.StorageCapacity);
            }
            if (search.SupportsExpandableStorage != null)
            {
                data = data.Where(x => x.SupportsExpandableStorage == search.SupportsExpandableStorage);
            }
            if (search.RearCamerasCount != null)
            {
                data = data.Where(x => x.RearCamerasCount >= search.RearCamerasCount);
            }
            if (search.HasUltrawideLens != null)
            {
                data = data.Where(x => x.HasUltrawideLens == search.HasUltrawideLens);
            }
            if (search.HasZoomLens != null)
            {
                data = data.Where(x => x.HasZoomLens == search.HasZoomLens);
            }
            if (search.MainCameraResolution_MP != null)
            {
                data = data.Where(x => x.MainCameraResolution_MP >= search.MainCameraResolution_MP);
            }
            if (search.FrontCameraResolution_MP != null)
            {
                data = data.Where(x => x.FrontCameraResolution_MP >= search.FrontCameraResolution_MP);
            }
            if (search.BatteryCapacity != null)
            {
                data = data.Where(x => x.BatteryCapacity >= search.BatteryCapacity);
            }
            if (search.SupportsFastCharging != null)
            {
                data = data.Where(x => x.SupportsFastCharging == search.SupportsFastCharging);
            }
            if (search.SupportsWirelessCharging != null)
            {
                data = data.Where(x => x.SupportsWirelessCharging == search.SupportsWirelessCharging);
            }
            if (search.EstimatedBatteryLife != null)
            {
                data = data.Where(x => x.EstimatedBatteryLife >= search.EstimatedBatteryLife);
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
            if (search.HasNFC != null)
            {
                data = data.Where(x => x.HasNFC == search.HasNFC);
            }
            if (search.HasDualSIM != null)
            {
                data = data.Where(x => x.HasDualSIM == search.HasDualSIM);
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
            if (!string.IsNullOrWhiteSpace(search.OperatingSystem))
            {
                data = data.Where(x => x.OperatingSystem.Contains(search.OperatingSystem));
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
