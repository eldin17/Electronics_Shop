import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class TabletDetails extends StatelessWidget {
  Product product;
  TabletDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFF7643),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // Product title and description
            Text(
              "${product.brand} ${product.model}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "${product.description}",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),

            // Technical Specifications Title
            Text(
              "Technical Specifications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 15),
            // Display
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Display",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Screen Size", "${product.tablet?.screenSize}"),
                    buildSpecificationRow("Screen Resolution",
                        "${product.tablet?.screenResolution}"),
                    buildSpecificationRow(
                        "Screen Type", "${product.tablet?.screenType}"),
                    buildSpecificationRow(
                        "Refresh Rate", "${product.tablet?.refreshRate} Hz"),
                  ],
                ),
              ),
            ),

            // Performance
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Performance",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Processor", "${product.tablet?.processor}"),
                    buildSpecificationRow("RAM", "${product.tablet?.ram} GB"),
                    buildSpecificationRow(
                        "Storage", "${product.tablet?.storageCapacity} GB"),
                    buildSpecificationRow("Expandable Storage",
                        "${product.tablet?.supportsExpandableStorage == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

            // Camera
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Camera",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("Rear Camera",
                        "${product.tablet?.rearCameraResolution}"),
                    buildSpecificationRow("Front Camera",
                        "${product.tablet?.frontCameraResolution}"),
                  ],
                ),
              ),
            ),

            // Battery
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Battery",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("Battery Capacity",
                        "${product.tablet?.batteryCapacity} mAh"),
                    buildSpecificationRow("Battery Life",
                        "${product.tablet?.estimatedBatteryLife} hours"),
                    buildSpecificationRow("Fast Charging",
                        "${product.tablet?.supportsFastCharging == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Wireless Charging",
                        "${product.tablet?.supportsWirelessCharging == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

            // Connectivity
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connectivity",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("5G Support",
                        "${product.tablet?.supports5G == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("WiFi 6",
                        "${product.tablet?.hasWiFi6 == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Bluetooth",
                        "${product.tablet?.hasBluetooth == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Cellular",
                        "${product.tablet?.hasCellular == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

            // Physical Characteristics
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Physical Characteristics",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Weight", "${product.tablet?.weight} g"),
                    buildSpecificationRow(
                        "Dimensions", "${product.tablet?.dimensions}"),
                    buildSpecificationRow(
                        "Build Material", "${product.tablet?.buildMaterial}"),
                  ],
                ),
              ),
            ),

            // Additional Features
            Card(
              color: Colors.white,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Features",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("Operating System",
                        "${product.tablet?.operatingSystem}"),
                    buildSpecificationRow("Stylus Support",
                        "${product.tablet?.supportsStylus == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Fingerprint Sensor",
                        "${product.tablet?.hasFingerprintSensor == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Face Recognition",
                        "${product.tablet?.hasFaceRecognition == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Water Resistant",
                        "${product.tablet?.isWaterResistant == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
