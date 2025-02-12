using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.DataTransferObjects
{
    public class DtoLaptop
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public virtual DtoProduct Product { get; set; }

        // Performance
        public string Processor { get; set; } // e.g., "Intel Core i7-12700H", "AMD Ryzen 7 5800U"
        public int RAM { get; set; } // RAM size in GB, e.g., 8, 16, 32
        public string StorageType { get; set; } // e.g., "SSD", "HDD"
        public int StorageCapacity { get; set; } // Storage size in GB or TB, e.g., 256, 512, 1000
        public string GraphicsCard { get; set; } // e.g., "NVIDIA RTX 3060", "Integrated Intel Iris Xe"

        // Display
        public string ScreenSize { get; set; } // e.g., "15.6 inches", "13.3 inches"
        public string ScreenResolution { get; set; } // e.g., "1920x1080", "3840x2160"
        public string ScreenType { get; set; } // e.g., "IPS", "OLED", "Touchscreen"

        // Battery
        public int BatteryCapacity { get; set; } // Battery capacity in Wh or mAh
        public int BatteryLife { get; set; } // Estimated battery life in hours, e.g., 10, 15

        // Connectivity
        public bool HasWiFi { get; set; } // Whether it has built-in WiFi
        public bool HasBluetooth { get; set; } // Whether it has built-in Bluetooth
        public int USBPorts { get; set; } // Number of USB ports, e.g., 3
        public bool HasEthernetPort { get; set; } // Whether it has an Ethernet port
        public bool HasHDMI { get; set; } // Whether it has an HDMI port
        public bool HasThunderbolt { get; set; } // Whether it supports Thunderbolt

        // Physical Characteristics
        public decimal Weight { get; set; } // Weight in kilograms, e.g., 1.5
        public string Dimensions { get; set; } // Dimensions in mm or inches, e.g., "357 x 230 x 15 mm"
        public string BuildMaterial { get; set; } // e.g., "Aluminum", "Plastic", "Carbon Fiber"

        // Additional Features
        public bool HasBacklitKeyboard { get; set; } // Whether the keyboard is backlit
        public bool HasFingerprintReader { get; set; } // For biometric security
        public bool HasWebcam { get; set; } // Whether it has a built-in webcam
        public string OperatingSystem { get; set; } // e.g., "Windows 11", "macOS", "Linux"
    }
}
