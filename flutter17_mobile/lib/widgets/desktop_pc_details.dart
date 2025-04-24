import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class DesktopPCDetails extends StatelessWidget {
  Product product;
  DesktopPCDetails({super.key, required this.product});

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
                      "General Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Processor", "${product.desktopPC?.processor}"),
                    buildSpecificationRow("RAM",
                        "${product.desktopPC?.ram} GB"),
                    buildSpecificationRow(
                        "Storage Type", "${product.desktopPC?.storageType}"),
                    buildSpecificationRow(
                        "Storage Capacity", "${product.desktopPC?.storageCapacity} GB"),
                  buildSpecificationRow(
                        "Graphics Card", "${product.desktopPC?.graphicsCard}"),
                  buildSpecificationRow(
                        "Operating System", "${product.desktopPC?.operatingSystem}"),
                  
                  ],
                ),
              ),
            ),
            Text("Processor - ${product.desktopPC?.processor}"),
            Text("RAM - ${product.desktopPC?.ram} GB"),
            Text("Storage Type - ${product.desktopPC?.storageType}"),
            Text("Storage Capacity - ${product.desktopPC?.storageCapacity} GB"),
            Text("Graphics Card - ${product.desktopPC?.graphicsCard}"),
            Text("Operating System - ${product.desktopPC?.operatingSystem}"),

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
                        "Form Factor", "${product.desktopPC?.formFactor}"),
                    buildSpecificationRow("Weight",
                        "${product.desktopPC?.weight} kg"),
                    buildSpecificationRow(
                        "Dimensions", "${product.desktopPC?.dimensions}"),
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
                    buildSpecificationRow(
                        "USB Ports", "${product.desktopPC?.usbPorts}"),
                    buildSpecificationRow("WiFi",
                        "${product.desktopPC?.hasWiFi == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Bluetooth",
                        "${product.desktopPC?.hasBluetooth == true ? 'Yes' : 'No'}"),
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
                      "Power Supply",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("Power Supply Wattage",
                        "${product.desktopPC?.powerSupplyWattage} W"),
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
                      "Cooling",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Cooling Type", "${product.desktopPC?.coolingType}"),
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
                    
                    buildSpecificationRow("Has RGB Lighting",
                        "${product.desktopPC?.hasRGBLighting == true ? 'Yes' : 'No'}"),
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
