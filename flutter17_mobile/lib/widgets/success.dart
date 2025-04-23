import 'package:flutter/material.dart';

void showSuccessPopup(BuildContext context, String messageText) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
      });

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              Text(messageText, style: TextStyle(fontSize: 14,color: Colors.green)),
            ],
          ),
        ),
      );
    },
  );
}