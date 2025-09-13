import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/payment_method.dart';

class PaymentMethodCardForSelection extends StatelessWidget {
  const PaymentMethodCardForSelection({
    Key? key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final PaymentMethod paymentMethod;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: paymentMethod.type == "Cash on Delivery"
                    ? Image.asset('assets/images/cash.jpg')
                    : paymentMethod.type == "Card on Delivery"
                        ? Image.asset('assets/images/card.jpg')
                        : paymentMethod.type == "Stripe Online"
                            ? Image.asset('assets/images/stripe.png')
                            : const Placeholder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              paymentMethod.type ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: onSelected,
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? Colors.green : null,
              foregroundColor: isSelected ? Colors.white : Colors.blueGrey,
            ),
            child: Text(isSelected ? "Selected" : "Select"),
          )
        ],
      ),
    );
  }
}
