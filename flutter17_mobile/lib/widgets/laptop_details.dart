import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class LaptopDetails extends StatelessWidget {
  Product product;
  LaptopDetails({super.key, required this.product});

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
            // Header Section
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

            // Technical Specifications Section
            Card(
              elevation: 4,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Technical Specifications",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Processor", product.laptop?.processor),
                    buildSpecificationRow("RAM", "${product.laptop?.ram} GB"),
                    buildSpecificationRow(
                        "Storage Type", product.laptop?.storageType),
                    buildSpecificationRow("Storage Capacity",
                        "${product.laptop?.storageCapacity} GB"),
                    buildSpecificationRow(
                        "Graphics Card", product.laptop?.graphicsCard),
                  ],
                ),
              ),
            ),

            // Display Section
            Card(
              elevation: 4,
              color: Colors.white,
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
                        "Screen Size", product.laptop?.screenSize),
                    buildSpecificationRow(
                        "Screen Resolution", product.laptop?.screenResolution),
                    buildSpecificationRow(
                        "Screen Type", product.laptop?.screenType),
                  ],
                ),
              ),
            ),

            // Battery Section
            Card(
              elevation: 4,
              color: Colors.white,
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
                        "${product.laptop?.batteryCapacity} Wh"),
                    buildSpecificationRow(
                        "Battery Life", "${product.laptop?.batteryLife} hours"),
                  ],
                ),
              ),
            ),

            // Connectivity Section
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
                    buildSpecificationRow(
                        "WiFi", product.laptop?.hasWiFi == true ? "Yes" : "No"),
                    buildSpecificationRow("Bluetooth",
                        product.laptop?.hasBluetooth == true ? "Yes" : "No"),
                    buildSpecificationRow(
                        "USB Ports", "${product.laptop?.usbPorts}"),
                    buildSpecificationRow("Ethernet Port",
                        product.laptop?.hasEthernetPort == true ? "Yes" : "No"),
                    buildSpecificationRow(
                        "HDMI", product.laptop?.hasHDMI == true ? "Yes" : "No"),
                    buildSpecificationRow("Thunderbolt",
                        product.laptop?.hasThunderbolt == true ? "Yes" : "No"),
                  ],
                ),
              ),
            ),

            // Physical Characteristics Section
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
                        "Weight", "${product.laptop?.weight} kg"),
                    buildSpecificationRow(
                        "Dimensions", product.laptop?.dimensions),
                    buildSpecificationRow(
                        "Build Material", product.laptop?.buildMaterial),
                  ],
                ),
              ),
            ),

            // Additional Features Section
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
                    buildSpecificationRow(
                        "Backlit Keyboard",
                        product.laptop?.hasBacklitKeyboard == true
                            ? "Yes"
                            : "No"),
                    buildSpecificationRow(
                        "Fingerprint Reader",
                        product.laptop?.hasFingerprintReader == true
                            ? "Yes"
                            : "No"),
                    buildSpecificationRow("Webcam",
                        product.laptop?.hasWebcam == true ? "Yes" : "No"),
                    buildSpecificationRow(
                        "Operating System", product.laptop?.operatingSystem),
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
