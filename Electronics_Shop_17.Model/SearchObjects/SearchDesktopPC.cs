using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchDesktopPC : BaseSearch
    {
        public int? Id { get; set; }
        public int? ProductId { get; set; }

        // General Information
        public string? Processor { get; set; } // e.g., "Intel Core i7-12700K", "AMD Ryzen 9 5900X"
        public int? Ram { get; set; } // RAM size in GB, e.g., 16, 32
        public string? StorageType { get; set; } // e.g., "SSD", "HDD", or "Hybrid"
        public int? StorageCapacity { get; set; } // Storage size in GB or TB, e.g., 512, 1000
        public string? GraphicsCard { get; set; } // e.g., "NVIDIA RTX 3080", "AMD Radeon RX 6700 XT"
        public string? OperatingSystem { get; set; } // e.g., "Windows 11", "Linux", "None"

        // Physical Characteristics
        public string? FormFactor { get; set; } // e.g., "Mini Tower", "Mid Tower", "Full Tower", "All-in-One"
        public double? Weight { get; set; } // Weight in kilograms
        public string? Dimensions { get; set; } // Dimensions in mm or inches, e.g., "450 x 200 x 400 mm"

        // Connectivity
        public int? UsbPorts { get; set; } // Number of USB ports, e.g., 6
        public bool? HasWiFi { get; set; } // Whether it has built-in WiFi
        public bool? HasBluetooth { get; set; } // Whether it has built-in Bluetooth

        // Power Supply
        public int? PowerSupplyWattage { get; set; } // PSU wattage, e.g., 750W

        // Cooling
        public string? CoolingType { get; set; } // e.g., "Air Cooling", "Liquid Cooling"

        // Additional Features
        public bool? HasRGBLighting { get; set; } // Whether the PC has RGB lighting
    }
}
