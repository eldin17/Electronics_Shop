using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Model.Requests
{
    public class AddTelevision
    {
        public int ProductId { get; set; }

        // Display
        public string ScreenSize { get; set; } // e.g., "55 inches", "65 inches"
        public string ScreenResolution { get; set; } // e.g., "4K UHD", "8K UHD", "Full HD"
        public string ScreenType { get; set; } // e.g., "OLED", "QLED", "LED", "Mini-LED"
        public bool IsSmartTV { get; set; } // Whether it supports smart features (apps, internet)
        public int RefreshRate { get; set; } // Refresh rate in Hz, e.g., 60, 120, 144
        public bool SupportsHDR { get; set; } // Whether it supports HDR (e.g., HDR10, Dolby Vision)

        // Audio
        public int SpeakerOutputPower { get; set; } // Speaker power in watts, e.g., 20, 40
        public bool SupportsDolbyAtmos { get; set; } // Whether it supports Dolby Atmos

        // Connectivity
        public int HDMIInputs { get; set; } // Number of HDMI inputs
        public int USBPorts { get; set; } // Number of USB ports
        public bool HasBluetooth { get; set; } // Whether it supports Bluetooth
        public bool HasWiFi { get; set; } // Whether it has WiFi

        // Features
        public string OperatingSystem { get; set; } // e.g., "Tizen", "WebOS", "Android TV"
        public bool SupportsVoiceControl { get; set; } // e.g., Alexa, Google Assistant
        public bool HasScreenMirroring { get; set; } // Whether it supports screen mirroring (e.g., AirPlay, Miracast)

        // Physical Characteristics
        public decimal Weight { get; set; } // Weight in kg, e.g., 15.5
        public string Dimensions { get; set; } // Dimensions in mm, e.g., "1228 x 707 x 25"
        public string StandType { get; set; } // e.g., "Central stand", "Side legs", "Wall mount"

        // Energy Efficiency
        public string EnergyRating { get; set; } // e.g., "A++", "B"
        public int PowerConsumption { get; set; } // Power usage in watts    
    }
}
