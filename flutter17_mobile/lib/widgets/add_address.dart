import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:provider/provider.dart';

import '../models/adress.dart';
import '../providers/adress_provider.dart';

class AddAddressModal extends StatefulWidget {
  const AddAddressModal({super.key});

  @override
  State<AddAddressModal> createState() => _AddAddressModalState();
}

class _AddAddressModalState extends State<AddAddressModal> {
  final _formKey = GlobalKey<FormState>();

  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalController = TextEditingController();

  bool isSaving = false;

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final provider = context.read<AdressProvider>();

    final newAdress = Adress(
      street: _streetController.text.trim(),
      city: _cityController.text.trim(),
      country: _countryController.text.trim(),
      postalCode: _postalController.text.trim(),
      isDeleted: false,
      customerId: LoginResponse.currentCustomer?.id,
      personId: LoginResponse.currentCustomer?.person?.id,
      
    );

    final createdAdress = await provider.add(newAdress);

    Navigator.pop(context, createdAdress);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add new address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _streetController,
              decoration: const InputDecoration(labelText: "Street"),
              validator: (v) =>
                  v == null || v.isEmpty ? "Street is required" : null,
            ),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: "City"),
              validator: (v) =>
                  v == null || v.isEmpty ? "City is required" : null,
            ),
            TextFormField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: "Country"),
              validator: (v) =>
                  v == null || v.isEmpty ? "Country is required" : null,
            ),
            TextFormField(
              controller: _postalController,
              decoration: const InputDecoration(labelText: "Postal code"),
              validator: (v) =>
                  v == null || v.isEmpty ? "Postal code is required" : null,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSaving ? null : _save,
                child: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Save address"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
