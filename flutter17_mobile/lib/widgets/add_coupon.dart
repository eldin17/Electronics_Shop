import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/login_screen.dart';

void showCouponPopup(BuildContext context,
    TextEditingController _couponController, VoidCallback function) {
  FormBuilderTextField couponInput() {
    return FormBuilderTextField(
      controller: _couponController,
      name: 'coupon',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Coupon is required';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: "Coupon",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(color: Color.fromARGB(209, 117, 117, 117)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
            ],
          ),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Color(0xFFFF7643)))),
    );
  }

  Text _description(BuildContext context) {
    return Text(
      "Savings are just one code away! 🚀",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
      ),
    );
  }

  Text _headline(BuildContext context) {
    return Text(
      "Got a Coupon?\nLet’s Save!",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              _headline(context),
              _description(
                context,
              ),
              SizedBox(height: 30),
              couponInput(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_couponController.text.isNotEmpty) {
                    print("BTN - Apply Coupon");
                    function();
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 2000),
                        content: Text(
                            'Oops! 🚫 That coupon code doesn\'t look right. Double-check and try again! 🕵️‍♂️✨'),
                        backgroundColor: Color.fromARGB(255, 158, 158, 158),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 155),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFFF7643),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: const Text("Apply Coupon"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
