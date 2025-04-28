import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/details_screen_section.dart';
import 'package:flutter17_mobile/widgets/product_details_see_more.dart';

class AccessoryDetails extends StatelessWidget {
  Product product;
  AccessoryDetails({super.key, required this.product});

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
            detailsSection(general()),
          ],
        ),
      ),
    );
  }

  Column general() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "General",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        showProperties(product),
      ],
    );
  }
}

Widget showProperties(Product product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: product.accessory!.accessoryProperties!.map((property) {
      return buildSpecificationRow(
        property.propertyName ?? '',
        property.propertyValue ?? '',
      );
    }).toList(),
  );
}
