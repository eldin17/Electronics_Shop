import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';

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
            Text(
              "${product.brand} ${product.model}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("${product.description}",
                style: TextStyle(fontStyle: FontStyle.italic)),
            SizedBox(height: 10),
            Text(
              "Technical Specifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("ACCESSORY"),
          ],
        ),
      ),
    );
  }
}
