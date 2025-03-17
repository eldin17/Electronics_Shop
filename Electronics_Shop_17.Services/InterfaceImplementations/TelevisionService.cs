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
    public class TelevisionService : BaseServiceCRUD<DtoTelevision, Television, SearchTelevision, AddTelevision, UpdateTelevision>, ITelevisionService
    {
        public TelevisionService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Television> AddFilter(IQueryable<Television> data, SearchTelevision? search)
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
            if (search.IsSmartTV != null)
            {
                data = data.Where(x => x.IsSmartTV == search.IsSmartTV);
            }
            if (search.RefreshRate != null)
            {
                data = data.Where(x => x.RefreshRate == search.RefreshRate);
            }
            if (search.SupportsHDR != null)
            {
                data = data.Where(x => x.SupportsHDR == search.SupportsHDR);
            }
            if (search.SpeakerOutputPower != null)
            {
                data = data.Where(x => x.SpeakerOutputPower == search.SpeakerOutputPower);
            }
            if (search.SupportsDolbyAtmos != null)
            {
                data = data.Where(x => x.SupportsDolbyAtmos == search.SupportsDolbyAtmos);
            }
            if (search.HdmiInputs != null)
            {
                data = data.Where(x => x.HdmiInputs == search.HdmiInputs);
            }
            if (search.UsbPorts != null)
            {
                data = data.Where(x => x.UsbPorts == search.UsbPorts);
            }
            if (search.HasBluetooth != null)
            {
                data = data.Where(x => x.HasBluetooth == search.HasBluetooth);
            }
            if (search.HasWiFi != null)
            {
                data = data.Where(x => x.HasWiFi == search.HasWiFi);
            }
            if (!string.IsNullOrEmpty(search.OperatingSystem))
            {
                data = data.Where(x => x.OperatingSystem == search.OperatingSystem);
            }
            if (search.SupportsVoiceControl != null)
            {
                data = data.Where(x => x.SupportsVoiceControl == search.SupportsVoiceControl);
            }
            if (search.HasScreenMirroring != null)
            {
                data = data.Where(x => x.HasScreenMirroring == search.HasScreenMirroring);
            }
            if (search.Weight != null)
            {
                data = data.Where(x => x.Weight == search.Weight);
            }
            if (!string.IsNullOrEmpty(search.Dimensions))
            {
                data = data.Where(x => x.Dimensions == search.Dimensions);
            }
            if (!string.IsNullOrEmpty(search.StandType))
            {
                data = data.Where(x => x.StandType == search.StandType);
            }
            if (!string.IsNullOrEmpty(search.EnergyRating))
            {
                data = data.Where(x => x.EnergyRating == search.EnergyRating);
            }
            if (search.PowerConsumption != null)
            {
                data = data.Where(x => x.PowerConsumption == search.PowerConsumption);
            }
            return base.AddFilter(data, search);
        }
    }
}
