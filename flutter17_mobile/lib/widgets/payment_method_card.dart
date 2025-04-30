import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.paymentMethod,
    required this.onPress,
    required this.align,
  }) : super(key: key);

  final double width, aspectRetio;
  final PaymentMethod paymentMethod;
  final VoidCallback onPress;
  final AlignmentGeometry align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: aspectRetio,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        
                      ],
                    ),
                    child: paymentMethod.provider == 'Customer'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildPaymentOption(
                              icon: Icons.attach_money,
                              label: "Cash",
                            ),                            
                          )
                        : paymentMethod.provider == 'Stripe'
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _buildPaymentOption(
                                  icon: Icons.credit_card,
                                  label: "Stripe",
                                ),
                              )
                            : Placeholder(),
                  ),
                ),
                const SizedBox(height: 8),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPaymentOption({
  required IconData icon,
  required String label,
}) {
  return GestureDetector(
    child: Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Icon(icon, size: 48, color: Colors.black54),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
