import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/payment_method_del.dart';
import 'package:flutter17_mobile/providers/payment_methods_provider.dart';
import 'package:provider/provider.dart';

class PaymentMethodCard extends StatefulWidget {
  const PaymentMethodCard({
    Key? key,
    required this.paymentMethod,
  }) : super(key: key);

  final PaymentMethod paymentMethod;

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  late PaymentMethodProvider _paymentMethodProvider;
  bool paymentMethodIsSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentMethodProvider = context.read<PaymentMethodProvider>();

    initForm();
  }

  Future initForm() async {
    var methods = await _paymentMethodProvider.getAll(filter: {
      'customerId': LoginResponse.currentCustomer!.id,
      'isDeleted': false
    });
    if (methods.data.isNotEmpty) {
      setState(() {
        paymentMethodIsSelected = methods.data
            .any((method) => method.type == widget.paymentMethod.type);
        print("asdasd ${methods.data.length}");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ****** EDIT ******* samo za stripe
      },
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
                child: widget.paymentMethod.type == "Cash on Delivery"
                    ? Image.asset('assets/images/cash.jpg')
                    : widget.paymentMethod.type == "Card on Delivery"
                        ? Image.asset('assets/images/card.jpg')
                        : widget.paymentMethod.type == "Stripe Online"
                            ? Image.asset('assets/images/stripe.png')
                            : const Placeholder(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.paymentMethod.type ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 8),
            ],
          ),
          const Spacer(),
          paymentMethodIsSelected
              ? Row(
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.close, color: Colors.orange),
                    //   onPressed: () async {
                    //     var delObj = PayMethDel(
                    //         customerId: LoginResponse.currentCustomer!.id,
                    //         type: widget.paymentMethod.type);
                    //     // var obj =
                    //     //     await _paymentMethodProvider.findAndDelete(delObj);
                    //     if (obj.isDeleted!) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           duration: Duration(milliseconds: 1500),
                    //           content: Text("❌ Payment Method removed"),
                    //           backgroundColor:
                    //               Color.fromARGB(255, 158, 158, 158),
                    //           behavior: SnackBarBehavior.floating,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(50),
                    //           ),
                    //           margin: EdgeInsets.only(
                    //               left: 20, right: 20, bottom: 20),
                    //         ),
                    //       );
                    //       setState(() {
                    //         paymentMethodIsSelected = false;
                    //       });
                    //     }
                    //   },
                    // ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (widget.paymentMethod.type != "Stripe Online") {
                      var obj = await _paymentMethodProvider.add({
                        'type': widget.paymentMethod.type,
                        'provider': widget.paymentMethod.provider,
                        'key': widget.paymentMethod.key,
                        'expiryDate': DateTime.now()
                            .add(Duration(days: 3000))
                            .toUtc()
                            .toIso8601String(),
                        'isDefault': widget.paymentMethod.isDefault,
                        "customerId": LoginResponse.currentCustomer!.id,
                        'isDeleted': false
                      });

                      if (obj.id! > 0) {
                        LoginResponse.currentCustomer!.paymentMethods?.add(obj);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content: Text("✅ Payment Method added"),
                            backgroundColor: Color.fromARGB(255, 158, 158, 158),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                          ),
                        );
                        setState(() {
                          paymentMethodIsSelected = true;
                        });
                      }
                    } else {
                      //************ STRIPE POPUP ***************
                    }
                  },
                  child: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color.fromARGB(176, 54, 122, 199),
                    foregroundColor: Colors.white,
                    maximumSize: const Size(double.infinity, 48),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
