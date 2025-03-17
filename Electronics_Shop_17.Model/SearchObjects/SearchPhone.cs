using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.SearchObjects
{
    public class SearchPhone : BaseSearch
    {
        public int? Id { get; set; }
        public int? ProductId { get; set; }

        // Display
        public string? ScreenSize { get; set; } // e.g., "6.1 inches", "6.7 inches"
        public string? ScreenResolution { get; set; } // e.g., "2532x1170", "2400x1080"
        public string? ScreenType { get; set; } // e.g., "OLED", "AMOLED", "LCD"
        public int? RefreshRate { get; set; } // Refresh rate in Hz, e.g., 60, 90, 120

        // Performance
        public string? Processor { get; set; } // e.g., "A16 Bionic", "Snapdragon 8 Gen 2", "Dimensity 920"
        public int? Ram { get; set; } // RAM size in GB, e.g., 4, 6, 8, 12
        public int? StorageCapacity { get; set; } // Internal storage in GB, e.g., 128, 256, 512
        public bool? SupportsExpandableStorage { get; set; } // Whether it supports microSD cards

        // Camera
        public int? RearCamerasCount { get; set; } // Number of rear cameras, e.g., 2, 3
        public bool? HasUltrawideLens { get; set; }
        public bool? HasZoomLens { get; set; }
        public int? MainCameraResolution { get; set; } // Main camera resolution, e.g., "50 MP"
        public int? FrontCameraResolution { get; set; } // Front camera resolution, e.g., "12 MP"

        // Battery
        public int? BatteryCapacity { get; set; } // Battery capacity in mAh, e.g., 4500
        public bool? SupportsFastCharging { get; set; } // Whether it supports fast charging
        public bool? SupportsWirelessCharging { get; set; } // Whether it supports wireless charging
        public int? EstimatedBatteryLife { get; set; } // Estimated battery life in hours

        // Connectivity
        public bool? Supports5G { get; set; } // Whether it supports 5G networks
        public bool? HasWiFi6 { get; set; } // Whether it supports WiFi 6
        public bool? HasBluetooth { get; set; } // Whether it has built-in Bluetooth
        public bool? HasNFC { get; set; } // Whether it supports NFC
        public bool? HasDualSIM { get; set; } // Whether it supports dual SIMs

        // Physical Characteristics
        public double? Weight { get; set; } // Weight in grams, e.g., 180
        public string? Dimensions { get; set; } // Dimensions in mm, e.g., "146.7 x 71.5 x 7.8"
        public string? BuildMaterial { get; set; } // e.g., "Aluminum", "Glass", "Plastic"

        // Additional Features
        public string? OperatingSystem { get; set; } // e.g., "iOS 17", "Android 13"
        public bool? HasFingerprintSensor { get; set; } // Whether it has a fingerprint scanner
        public bool? HasFaceRecognition { get; set; } // Whether it supports face recognition
        public bool? IsWaterResistant { get; set; } // Whether it has water resistance (e.g., IP68)
    }
}
