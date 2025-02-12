using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class Tablet : IHelperId
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        //public virtual Product Product { get; set; }

        // Display
        public string ScreenSize { get; set; } // e.g., "10.9 inches", "12.4 inches"
        public string ScreenResolution { get; set; } // e.g., "2360x1640", "2800x1752"
        public string ScreenType { get; set; } // e.g., "LCD", "AMOLED", "Mini-LED"
        public int RefreshRate { get; set; } // Refresh rate in Hz, e.g., 60, 90, 120

        // Performance
        public string Processor { get; set; } // e.g., "Apple M1", "Qualcomm Snapdragon 8 Gen 2"
        public int RAM { get; set; } // RAM size in GB, e.g., 4, 8, 16
        public int StorageCapacity { get; set; } // Internal storage in GB, e.g., 64, 128, 256
        public bool SupportsExpandableStorage { get; set; } // Whether it supports microSD cards

        // Camera
        public string RearCameraResolution { get; set; } // Rear camera resolution, e.g., "12 MP"
        public string FrontCameraResolution { get; set; } // Front camera resolution, e.g., "7 MP"

        // Battery
        public int BatteryCapacity { get; set; } // Battery capacity in mAh, e.g., 8000
        public int EstimatedBatteryLife { get; set; } // Estimated battery life in hours
        public bool SupportsFastCharging { get; set; } // Whether it supports fast charging
        public bool SupportsWirelessCharging { get; set; } // Whether it supports wireless charging

        // Connectivity
        public bool Supports5G { get; set; } // Whether it supports 5G
        public bool HasWiFi6 { get; set; } // Whether it supports WiFi 6
        public bool HasBluetooth { get; set; } // Whether it has Bluetooth
        public bool HasCellular { get; set; } // Whether it supports cellular networks (e.g., LTE, 5G)

        // Physical Characteristics
        public decimal Weight { get; set; } // Weight in grams, e.g., 460
        public string Dimensions { get; set; } // Dimensions in mm, e.g., "247.6 x 178.5 x 6.1"
        public string BuildMaterial { get; set; } // e.g., "Aluminum", "Plastic", "Glass"

        // Additional Features
        public string OperatingSystem { get; set; } // e.g., "iPadOS", "Android 13"
        public bool SupportsStylus { get; set; } // Whether it supports a stylus (e.g., Apple Pencil, S Pen)
        public bool HasFingerprintSensor { get; set; } // Whether it has a fingerprint scanner
        public bool HasFaceRecognition { get; set; } // Whether it supports face recognition
        public bool IsWaterResistant { get; set; } // e.g., "IP68 water resistance"
    }
}
