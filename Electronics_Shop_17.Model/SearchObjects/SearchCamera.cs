using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchCamera : BaseSearch
    {
        public int? Id { get; set; }
        public int? ProductId { get; set; }

        // Technical Specifications
        public double? Megapixels { get; set; } // Sensor resolution
        public string? SensorType { get; set; } // e.g., Full-frame, APS-C, Micro Four Thirds
        public string? LensMount { get; set; } // e.g., Canon RF, Nikon Z
        public string? VideoResolution { get; set; } // e.g., "4K at 60fps"

        // Physical Characteristics
        public double? Weight { get; set; } // Weight in grams
        public string? Dimensions { get; set; } // e.g., "138 x 97 x 88 mm"

        // Connectivity
        public bool? HasWiFi { get; set; }
        public bool? HasBluetooth { get; set; }

        // Battery
        public string? BatteryType { get; set; } // e.g., "LP-E6NH"
        public int? BatteryLife { get; set; } // Number of shots or recording time in minutes
    }
}
