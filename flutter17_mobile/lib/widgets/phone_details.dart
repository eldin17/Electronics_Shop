import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class PhoneDetails extends StatelessWidget {
  Product product;
  PhoneDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header line
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
                        "Screen Size", "${product.phone?.screenSize}"),
                    buildSpecificationRow("Screen Resolution",
                        "${product.phone?.screenResolution}"),
                    buildSpecificationRow(
                        "Screen Type", "${product.phone?.screenType}"),
                    buildSpecificationRow(
                        "Refresh Rate", "${product.phone?.refreshRate} Hz"),
                  ],
                ),
              ),
            ),
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
                        "Processor", "${product.phone?.processor}"),
                    buildSpecificationRow("RAM", "${product.phone?.ram} GB"),
                    buildSpecificationRow("Storage Capacity",
                        "${product.phone?.storageCapacity} GB"),
                    buildSpecificationRow("Expandable Storage",
                        "${product.phone?.supportsExpandableStorage == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),
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
                    buildSpecificationRow(
                        "Rear Cameras", "${product.phone?.rearCamerasCount}"),
                    buildSpecificationRow("Main Camera",
                        "${product.phone?.mainCameraResolution} MP"),
                    buildSpecificationRow("Front Camera",
                        "${product.phone?.frontCameraResolution} MP"),
                    buildSpecificationRow("Ultrawide Lens",
                        "${product.phone?.hasUltrawideLens == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Zoom Lens",
                        "${product.phone?.hasZoomLens == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

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
                        "${product.phone?.batteryCapacity} mAh"),
                    buildSpecificationRow("Fast Charging",
                        "${product.phone?.supportsFastCharging == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Wireless Charging",
                        "${product.phone?.supportsWirelessCharging == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Estimated Battery Life",
                        "${product.phone?.estimatedBatteryLife} hours"),
                  ],
                ),
              ),
            ),

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
                        "${product.phone?.supports5G == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("WiFi 6",
                        "${product.phone?.hasWiFi6 == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Bluetooth",
                        "${product.phone?.hasBluetooth == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("NFC",
                        "${product.phone?.hasNFC == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Dual SIM",
                        "${product.phone?.hasDualSIM == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

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
                        "Weight", "${product.phone?.weight} g"),
                    buildSpecificationRow(
                        "Dimensions", "${product.phone?.dimensions}"),
                    buildSpecificationRow(
                        "Build Material", "${product.phone?.buildMaterial}"),
                  ],
                ),
              ),
            ),

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
                        "${product.phone?.operatingSystem}"),
                    buildSpecificationRow("Fingerprint Sensor",
                        "${product.phone?.hasFingerprintSensor == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Face Recognition",
                        "${product.phone?.hasFaceRecognition == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Water Resistant",
                        "${product.phone?.isWaterResistant == true ? 'Yes' : 'No'}"),
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
