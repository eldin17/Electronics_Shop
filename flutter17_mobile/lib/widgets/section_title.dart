import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.showSeeMore,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  bool showSeeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        showSeeMore
            ? TextButton(
                onPressed: press,
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: Row(
                  children: [
                    const Text("See more"),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
