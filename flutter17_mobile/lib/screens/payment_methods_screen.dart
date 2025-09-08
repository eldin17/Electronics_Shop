import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/coupon_provider.dart';
import 'package:flutter17_mobile/providers/payment_methods_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_item_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_provider.dart';
import 'package:flutter17_mobile/screens/no_cart.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/widgets/add_coupon.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter17_mobile/widgets/payment_method_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late PaymentMethodProvider _paymentMethodProvider;

  List<PaymentMethod> listPaymentMethods = [
    PaymentMethod(
      id: 1,
      type: 'Cash on Delivery',
      provider: 'Internal',
      key: 'cash_cod',
      isDefault: true,
      isDeleted: false,
    ),
    PaymentMethod(
      id: 2,
      type: 'Card on Delivery',
      provider: 'POS Terminal',
      key: 'card_cod',
      isDefault: false,
      isDeleted: false,
    ),
    PaymentMethod(
      id: 3,
      type: 'Stripe Online',
      provider: 'Stripe',
      key: 'stripe_online',
      expiryDate: null,
      isDefault: false,
      isDeleted: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _paymentMethodProvider = context.read<PaymentMethodProvider>();

      initForm();
    
  }

  Future initForm() async {
    

    setState(() {
      
    });
  }

  Future removeItem(int id) async {
    await _paymentMethodProvider.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: PaymentMethodCard(paymentMethod: listPaymentMethods[index]),
                ),
              ),
            ),
          ),
          const Text("🔒 Your data is secure."),
          const SizedBox(height: 350,)
        ],
      ),
    );
  }
}


