import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/details_screen_section.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class GamingConsoleDetails extends StatelessWidget {
  Product product;
  GamingConsoleDetails({super.key, required this.product});

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

            // General Information
            detailsSection(generalInfo()),
            

            // Performance
            detailsSection(performance()),

            

            // Connectivity
            detailsSection(connectivity()),
            

            // Features
            detailsSection(features()),
            

            // Additional Features
            detailsSection(additionalFeatures()),

            detailsSection(physicalCharacteristics()),
            
            
          ],
        ),
      ),
    );
  }

  Column physicalCharacteristics() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Physical Characteristics",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildSpecificationRow(
                      "Weight", "${product.gamingConsole?.weight} kg"),
                  buildSpecificationRow(
                      "Dimensions", "${product.gamingConsole?.dimensions}"),
                ],
              );
  }

  Column additionalFeatures() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Additional Features",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildSpecificationRow("Controller Type",
                      "${product.gamingConsole?.controllerType}"),
                  buildSpecificationRow("Backward Compatibility",
                      "${product.gamingConsole?.supportsBackwardCompatibility == true ? 'Yes' : 'No'}"),
                  buildSpecificationRow("Online Service",
                      "${product.gamingConsole?.onlineService}"),
                ],
              );
  }

  Column features() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Features",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildSpecificationRow("VR",
                      "${product.gamingConsole?.supportsVR == true ? 'Yes' : 'No'}"),
                  buildSpecificationRow("Physical Media Drive",
                      "${product.gamingConsole?.hasPhysicalMediaDrive == true ? 'Yes' : 'No'}"),
                  buildSpecificationRow("Portable",
                      "${product.gamingConsole?.isPortable == true ? 'Yes' : 'No'}"),
                ],
              );
  }

  Column connectivity() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connectivity",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildSpecificationRow(
                      "USB Ports", "${product.gamingConsole?.usbPorts}"),
                  buildSpecificationRow("WiFi",
                      "${product.gamingConsole?.hasWiFi == true ? 'Yes' : 'No'}"),
                  buildSpecificationRow("Bluetooth",
                      "${product.gamingConsole?.hasBluetooth == true ? 'Yes' : 'No'}"),
                  buildSpecificationRow("Ethernet Port",
                      "${product.gamingConsole?.hasEthernetPort == true ? 'Yes' : 'No'}"),
                  buildSpecificationRow("External Storage",
                      "${product.gamingConsole?.supportsExternalStorage == true ? 'Yes' : 'No'}"),
                ],
              );
  }

  Column performance() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Performance",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildSpecificationRow(
                      "RAM", "${product.gamingConsole?.ram} GB"),
                  buildSpecificationRow("Storage Type",
                      "${product.gamingConsole?.storageType}"),
                  buildSpecificationRow("Storage Capacity",
                      "${product.gamingConsole?.storageCapacity} GB"),
                  buildSpecificationRow("Max Resolution",
                      "${product.gamingConsole?.maxResolution}"),
                  buildSpecificationRow(
                      "Max FPS", "${product.gamingConsole?.maxFPS}"),
                ],
              );
  }

  Column generalInfo() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "General Information",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildSpecificationRow(
                      "Processor", "${product.gamingConsole?.processor}"),
                  buildSpecificationRow("Graphics Processor",
                      "${product.gamingConsole?.graphicsProcessor}"),
                ],
              );
  }
}
