import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/details_screen_section.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class CameraDetails extends StatelessWidget {
  Product product;
  CameraDetails({super.key, required this.product});

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

            Text(
              "Technical Specifications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 15),
            detailsSection(sensor()),
            detailsSection(physicalCharacteristics()),
            detailsSection(connectivity()),
            detailsSection(battery()),
          ],
        ),
      ),
    );
  }

  Column battery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Battery",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        buildSpecificationRow("Battery Type", "${product.camera?.batteryType}"),
        buildSpecificationRow(
            "Battery Life", "${product.camera?.batteryLife} mAh"),
      ],
    );
  }

  Column connectivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Connectivity",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        buildSpecificationRow(
            "WiFi", "${product.camera?.hasWiFi == true ? 'Yes' : 'No'}"),
        buildSpecificationRow("Bluetooth",
            "${product.camera?.hasBluetooth == true ? 'Yes' : 'No'}"),
      ],
    );
  }

  Column physicalCharacteristics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Physical Characteristics",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        buildSpecificationRow("Weight", "${product.camera?.weight} kg"),
        buildSpecificationRow(
            "Dimensions", "${product.camera?.dimensions} (cm)"),
      ],
    );
  }

  Column sensor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sensor",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        buildSpecificationRow(
            "Megapixels", "${product.camera?.megapixels!.toInt()}"),
        buildSpecificationRow("Sensor Type", "${product.camera?.sensorType}"),
        buildSpecificationRow("Lens Mount", "${product.camera?.lensMount}"),
        buildSpecificationRow(
            "Video Resolution", "${product.camera?.videoResolution}"),
      ],
    );
  }
}
