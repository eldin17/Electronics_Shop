import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class TelevisionDetails extends StatelessWidget {
  Product product;
  TelevisionDetails({super.key, required this.product});

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
                        "Screen Size", "${product.television?.screenSize}"),
                    buildSpecificationRow("Resolution",
                        "${product.television?.screenResolution}"),
                    buildSpecificationRow(
                        "Screen Type", "${product.television?.screenType}"),
                    buildSpecificationRow("Smart TV",
                        "${product.television?.isSmartTV == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Refresh Rate",
                        "${product.television?.refreshRate} Hz"),
                    buildSpecificationRow("HDR Support",
                        "${product.television?.supportsHDR == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

            // Audio
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
                      "Audio",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("Speaker Output",
                        "${product.television?.speakerOutputPower} W"),
                    buildSpecificationRow("Dolby Atmos",
                        "${product.television?.supportsDolbyAtmos == true ? 'Yes' : 'No'}"),
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
                    buildSpecificationRow(
                        "HDMI Inputs", "${product.television?.hdmiInputs}"),
                    buildSpecificationRow(
                        "USB Ports", "${product.television?.usbPorts}"),
                    buildSpecificationRow("Bluetooth",
                        "${product.television?.hasBluetooth == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("WiFi",
                        "${product.television?.hasWiFi == true ? 'Yes' : 'No'}"),
                  ],
                ),
              ),
            ),

            // Features
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
                      "Features",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow("Operating System",
                        "${product.television?.operatingSystem}"),
                    buildSpecificationRow("Voice Control",
                        "${product.television?.supportsVoiceControl == true ? 'Yes' : 'No'}"),
                    buildSpecificationRow("Screen Mirroring",
                        "${product.television?.hasScreenMirroring == true ? 'Yes' : 'No'}"),
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
                        "Weight", "${product.television?.weight} kg"),
                    buildSpecificationRow(
                        "Dimensions", "${product.television?.dimensions}"),
                    buildSpecificationRow(
                        "Stand Type", "${product.television?.standType}"),
                  ],
                ),
              ),
            ),

            // Energy Efficiency
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
                      "Energy Efficiency",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    buildSpecificationRow(
                        "Energy Rating", "${product.television?.energyRating}"),
                    buildSpecificationRow("Power Consumption",
                        "${product.television?.powerConsumption} W"),
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
