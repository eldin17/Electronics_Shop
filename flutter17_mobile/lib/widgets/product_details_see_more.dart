import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/widgets/accessory_details.dart';
import 'package:flutter17_mobile/widgets/camera_details.dart';
import 'package:flutter17_mobile/widgets/console_details.dart';
import 'package:flutter17_mobile/widgets/desktop_pc_details.dart';
import 'package:flutter17_mobile/widgets/laptop_details.dart';
import 'package:flutter17_mobile/widgets/phone_details.dart';
import 'package:flutter17_mobile/widgets/tablet_details.dart';
import 'package:flutter17_mobile/widgets/television_details.dart';

class SeeMoreDetails extends StatefulWidget {
  Product product;
  SeeMoreDetails({super.key, required this.product});

  @override
  State<SeeMoreDetails> createState() => _SeeMoreDetailsState();
}

class _SeeMoreDetailsState extends State<SeeMoreDetails> {
  @override
  Widget build(BuildContext context) {
    switch (widget.product.productCategory?.name) {
      case "Camera":
        return Container(
          height: 500,
          child: CameraDetails(
            product: widget.product,
          ),
        );
      case "Desktop PC":
        return Container(
          height: 500,
          child: DesktopPCDetails(
            product: widget.product,
          ),
        );
      case "Gaming Console":
        return Container(
          height: 500,
          child: GamingConsoleDetails(
            product: widget.product,
          ),
        );
      case "Laptop":
        return Container(
          height: 500,
          child: LaptopDetails(
            product: widget.product,
          ),
        );
      case "Phone":
        return Container(
          height: 500,
          child: PhoneDetails(
            product: widget.product,
          ),
        );
      case "Tablet":
        return Container(
          height: 500,
          child: TabletDetails(
            product: widget.product,
          ),
        );
      case "Television":
        return Container(
          height: 500,
          child: TelevisionDetails(
            product: widget.product,
          ),
        );
      case "Accessory":
        return Container(
          height: 500,
          child: AccessoryDetails(
            product: widget.product,
          ),
        );
      default:
        return Container();
    }
  }
}
Widget buildSpecificationRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value ?? "Not Available"),
          ),
        ],
      ),
    );
  }
