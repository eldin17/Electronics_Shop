import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/adress.dart';

class AdressCardForSelection extends StatelessWidget {
  const AdressCardForSelection({
    Key? key,
    required this.adress,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final Adress adress;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon/avatar for address
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.home, size: 30, color: Colors.blueGrey),
          ),
          const SizedBox(width: 20),

          // Address info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adress.street ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${adress.city ?? ""}, ${adress.postalCode ?? ""}",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  adress.country ?? "",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Select button / check
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
