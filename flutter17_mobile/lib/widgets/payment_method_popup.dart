import 'package:flutter/material.dart';

void showPaymentMethodPopup(
  BuildContext context, {
  required bool initialCashSelected,
  required bool initialStripeSelected,
  required void Function(bool cash, bool stripe) onConfirm,
}) {
  bool isCashSelected = initialCashSelected;
  bool isStripeSelected = initialStripeSelected;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPaymentOption(
                      icon: Icons.attach_money,
                      label: "Cash",
                      selected: isCashSelected,
                      onTap: () =>
                          setState(() => isCashSelected = !isCashSelected),
                    ),
                    _buildPaymentOption(
                      icon: Icons.credit_card,
                      label: "Stripe",
                      selected: isStripeSelected,
                      onTap: () =>
                          setState(() => isStripeSelected = !isStripeSelected),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm(isCashSelected, isStripeSelected);
                },
                child: Text("Confirm"),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _buildPaymentOption({
  required IconData icon,
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: selected
                ? Colors.orange.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? Colors.orange : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Icon(icon,
              size: 48, color: selected ? Colors.orange : Colors.black54),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
