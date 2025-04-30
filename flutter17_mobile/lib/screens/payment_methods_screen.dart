import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/customer.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/search_result.dart';
import 'package:flutter17_mobile/providers/customer_provider.dart';
import 'package:flutter17_mobile/providers/product_provider.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/no_products.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/widgets/btn_counter.dart';
import 'package:flutter17_mobile/widgets/payment_method_card.dart';
import 'package:flutter17_mobile/widgets/product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PaymentMethodsScreen extends StatefulWidget {
  String searchBox;
  bool fromLatest;
  bool fromOnDiscount;
  bool showScreenIfEmpty;

  String category;

  PaymentMethodsScreen({
    super.key,
    this.fromLatest = false,
    this.fromOnDiscount = false,
    this.showScreenIfEmpty = false,
    this.category = "",
    this.searchBox = "",
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late CustomerProvider _customerProvider;
  List<PaymentMethod> paymentMethodsList = [];
  bool isLoading = true;
  late Customer test;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _customerProvider = context.read<CustomerProvider>();
    initForm();
  }

  Future initForm() async {
    var obj = await _customerProvider
        .getById(LoginResponse.currentCustomer!.id!);

    setState(() {
      
      test = obj;
      
      paymentMethodsList = test.paymentMethods!;
      isLoading = false;
    });
  }  

  

  

  @override
  Widget build(BuildContext context) {
    return widget.showScreenIfEmpty && paymentMethodsList.length < 1
        ? !isLoading
            ? EmptyNotificationsScreen()
            : Container()
        : !isLoading
            ? testING(context)
            : Container();
  }

  Scaffold testING(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        //title: Center(child: const Text("Products")),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: const Color(0xFFF5F6F9),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              listContents(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded listContents() {
    return Expanded(
      child: GridView.builder(
        itemCount: paymentMethodsList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.7,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => PaymentMethodCard(
          align: Alignment.topRight,
          paymentMethod: paymentMethodsList[index],
          onPress: () {
            
          },
        ),
      ),
    );
  }
}
