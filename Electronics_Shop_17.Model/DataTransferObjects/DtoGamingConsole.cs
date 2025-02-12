using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoGamingConsole
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public virtual DtoProduct Product { get; set; }

        // General Information        
        public string Processor { get; set; } // e.g., "AMD Zen 2", "Custom NVIDIA Tegra X1"
        public string GraphicsProcessor { get; set; } // e.g., "RDNA 2 GPU", "NVIDIA GPU"

        // Performance
        public int RAM { get; set; } // RAM size in GB, e.g., 16
        public string StorageType { get; set; } // e.g., "SSD", "HDD", or "Expandable Storage"
        public int StorageCapacity { get; set; } // Storage size in GB or TB, e.g., 512, 1000
        public string MaxResolution { get; set; } // e.g., "4K", "8K", or "1080p"
        public int MaxFPS { get; set; } // Maximum Frames Per Second, e.g., 60, 120

        // Connectivity
        public int USBPorts { get; set; } // Number of USB ports, e.g., 3
        public bool HasWiFi { get; set; } // Whether it has built-in WiFi
        public bool HasBluetooth { get; set; } // Whether it has built-in Bluetooth
        public bool HasEthernetPort { get; set; } // Whether it has an Ethernet port
        public bool SupportsExternalStorage { get; set; } // Whether it supports external drives

        // Features
        public bool SupportsVR { get; set; } // Whether it supports Virtual Reality
        public bool HasPhysicalMediaDrive { get; set; } // e.g., for Blu-ray discs
        public bool IsPortable { get; set; } // e.g., "true" for Nintendo Switch, "false" for PlayStation 5

        // Additional Features
        public string ControllerType { get; set; } // e.g., "DualSense", "Xbox Wireless Controller"
        public bool SupportsBackwardCompatibility { get; set; } // Can it play older games?
        public string OnlineService { get; set; } // e.g., "PlayStation Plus", "Xbox Game Pass"

        // Dimensions and Weight
        public decimal Weight { get; set; } // Weight in kilograms
        public string Dimensions { get; set; } // Dimensions in mm or inches, e.g., "390 x 260 x 104 mm"
    }
}
