import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/coupon_provider.dart';
import 'package:flutter17_mobile/providers/order_provider.dart';
import 'package:flutter17_mobile/providers/payment_methods_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_item_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_provider.dart';
import 'package:flutter17_mobile/screens/no_cart.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/screens/profile_screen.dart';
import 'package:flutter17_mobile/screens/shopping_cart_screen.dart';
import 'package:flutter17_mobile/widgets/add_coupon.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter17_mobile/widgets/payment_method_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

import '../models/order.dart';
import '../providers/adress_provider.dart';
import '../widgets/add_address.dart';
import '../widgets/adress_card_select.dart';
import '../widgets/fail.dart';
import '../widgets/payment_method_card_select.dart';
import '../widgets/section.dart';
import '../widgets/success.dart';
import 'order_review_screen.dart';

class PaymentMethodsSelectScreen extends StatefulWidget {
  Order draftOrder;
  PaymentMethodsSelectScreen({super.key, required this.draftOrder});

  @override
  State<PaymentMethodsSelectScreen> createState() =>
      _PaymentMethodsSelectScreenState();
}

class _PaymentMethodsSelectScreenState
    extends State<PaymentMethodsSelectScreen> {
  late PaymentMethodProvider _paymentMethodProvider;
  late OrderProvider _orderProvider;
  late AdressProvider _adressProvider;
  bool isLoading = true;
  late PaymentMethod? selectedMethod;
  late Adress? selectedAdress;
  var listPaymentMethods;
  var listAdress;

  @override
  void initState() {
    super.initState();
    _paymentMethodProvider = context.read<PaymentMethodProvider>();
    _orderProvider = context.read<OrderProvider>();
    _adressProvider = context.read<AdressProvider>();
  
    initForm();
  }

  Future initForm() async {
    var paymentMethods = await _paymentMethodProvider.getAll();

    var adress = await _adressProvider.getAll(filter: {
      'customerId': LoginResponse.currentCustomer!.id,
    });

    setState(() {
      listPaymentMethods = paymentMethods.data;
      listAdress = adress.data;
      print("qweqweqwe ${listAdress.length}");

      selectedMethod = PaymentMethod();
      selectedAdress = Adress();

      isLoading = false;
    });
  }

  onMethodSelect(int index) {
    setState(() {
      if (selectedMethod == listPaymentMethods[index]) {
        selectedMethod = null;
      } else {
        selectedMethod = listPaymentMethods[index];
      }
    });
    print(selectedMethod?.type ?? "No payment method selected");
  }

  onAdressSelect(int index) {
    setState(() {
      if (selectedAdress == listAdress[index]) {
        selectedAdress = null;
      } else {
        selectedAdress = listAdress[index];
      }
    });

    print(selectedAdress?.city ?? "No address selected");
  }

  Future<void> _openAddAddressModal() async {
    final result = await showModalBottomSheet<Adress>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddAddressModal(),
        );
      },
    );

    if (result != null) {
      setState(() {
        listAdress.add(result);
        selectedAdress = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          children: [],
        ),
      ),
      body: isLoading
          ? LoadingScreen()
          : Column(
              children: [
                Section(
                  title: "Payment method",
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listPaymentMethods.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: PaymentMethodCardForSelection(
                        paymentMethod: listPaymentMethods[index],
                        isSelected: selectedMethod == listPaymentMethods[index],
                        onSelected: () => onMethodSelect(index),
                      ),
                    ),
                  ),
                ),
                Section(
                  title: "Delivery address",
                  action: TextButton.icon(
                    onPressed: _openAddAddressModal,
                    icon: const Icon(Icons.add),
                    label: const Text("Add new"),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listAdress.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: AdressCardForSelection(
                        adress: listAdress[index],
                        isSelected: selectedAdress == listAdress[index],
                        onSelected: () => onAdressSelect(index),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFFF7643),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            var obj = await _orderProvider
                                .delete(widget.draftOrder.id!);
                            print("Delete Order Method CALL ${obj}");
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return const Color(0xFFFF7643)
                                      .withOpacity(0.5);
                                }
                                return const Color(0xFFFF7643);
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 48)),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                            ),
                          ),
                          onPressed: (selectedAdress?.id != null &&
                                  selectedMethod?.id != null)
                              ? () async {
                                  print(widget.draftOrder.couponId);

                                  var obj =
                                      await _orderProvider.checkAndActivate({
                                    'orderId': widget.draftOrder.id,
                                    'adressId': selectedAdress!.id,
                                    'paymentMethodId': selectedMethod!.id,
                                  });

                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 150),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          obj.newOrder == null
                                              ? OrderReviewScreen(
                                                  currentOrder: obj.oldOrder!,
                                                  orderSuggestion: false,
                                                  paymentMethodId:
                                                      selectedMethod!.id!,
                                                )
                                              : OrderReviewScreen(
                                                  currentOrder: obj.newOrder!,
                                                  orderSuggestion: true,
                                                  paymentMethodId:
                                                      selectedMethod!.id!,
                                                ),
                                    ),
                                  );

                                  print("NEXT CALL");
                                }
                              : null,
                          child: const Text("Next"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
