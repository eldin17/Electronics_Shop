import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:flutter17_mobile/models/order.dart';
import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/order_provider.dart';
import 'package:flutter17_mobile/screens/no_cart.dart';
import 'package:flutter17_mobile/screens/payment_methods_select.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/screens/shopping_cart_screen.dart';
import 'package:flutter17_mobile/widgets/add_coupon.dart';
import 'package:flutter17_mobile/widgets/fail.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/order_item.dart';
import '../providers/order_item_provider.dart';
import '../widgets/success.dart';

class OrderReviewScreen extends StatefulWidget {
  Order currentOrder;
  bool orderSuggestion;
  OrderReviewScreen(
      {super.key, required this.currentOrder, required this.orderSuggestion});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  late OrderProvider _orderProvider;
  late OrderItemProvider _orderItemProvider;

  bool isLoading = true;
  double totalPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderProvider = context.read<OrderProvider>();
    _orderItemProvider = context.read<OrderItemProvider>();

    if (LoginResponse.currentCustomer!.shoppingCart != null) {
      initForm();
    } else {
      isLoading = false;
    }
  }

  Future initForm() async {
    setState(() {
      totalPrice = widget.currentOrder.finalTotalAmount!;
      isLoading = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('💡  Swipe left to remove items'),
          backgroundColor: Color.fromARGB(255, 158, 158, 158),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 155),
        ),
      );
    });
  }

  Future removeItem(int id) async {
    await _orderItemProvider.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading && widget.currentOrder.orderItems != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: SizedBox(),
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  !widget.orderSuggestion
                      ? const Text(
                          "Review Your Order",
                          style: TextStyle(color: Colors.black),
                        )
                      : const Text(
                          "Try This Instead",
                          style: TextStyle(color: Colors.black),
                        ),
                  Text(
                    "${widget.currentOrder.orderItems?.length ?? 0} items",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: widget.currentOrder.orderItems?.length ?? 0,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(
                        widget.currentOrder.orderItems![index].id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      var deletedItem = widget.currentOrder.orderItems![index];

                      Future.delayed(Duration.zero, () {
                        setState(() {
                          totalPrice -=
                              deletedItem.finalPrice! * deletedItem.quantity!;
                          widget.currentOrder.orderItems!.removeAt(index);
                        });

                        removeItem(deletedItem.id!);

                        


                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text(
                                '${deletedItem.product!.brand} ${deletedItem.product!.model} - Removed  ❌')),
                      );
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.string(trashIcon),
                        ],
                      ),
                    ),
                    child: OrderCard(
                        orderItem: widget.currentOrder.orderItems![index],
                        totalPrice: totalPrice),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CheckoutCard(
              total: totalPrice ?? 0,
              orderObj: widget.currentOrder,
            ),
          )
        : !isLoading
            ? NoCartScreen()
            : LoadingScreen();
  }
}

class OrderCard extends StatefulWidget {
  OrderCard({
    Key? key,
    required this.orderItem,
    required this.totalPrice,
  }) : super(key: key);

  final OrderItem orderItem;
  double totalPrice;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String imageToShow = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imageToShow = widget.orderItem.product!.productImages!
        .where((element) =>
            element.productColor!.id == widget.orderItem.productColorId)
        .first
        .image!
        .path!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 150),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProductDetailsScreen(
                    selectedProduct: widget.orderItem.product!,
                    selectedProductColor123: widget.orderItem.productColor,
                    productId: widget.orderItem.product!.id!,
                  )),
        );
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
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 156, 156, 156).withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4), // Soft drop shadow
                    ),
                  ],
                ),
                child: Image.network(
                  adjustImage(imageToShow),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "${widget.orderItem.product!.brand!} ${widget.orderItem.product!.model!}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.orderItem.finalPrice == widget.orderItem.price
                      ? RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 118, 67),
                            ),
                            children: [
                              TextSpan(
                                  text: "${widget.orderItem.finalPrice}€     "),
                              TextSpan(
                                text: "x${widget.orderItem.quantity}",
                                style: const TextStyle(
                                  color: Colors
                                      .grey, // <- different color for quantity
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.orderItem.price}€",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        Color.fromARGB(141, 158, 158, 158),
                                    decorationThickness: 3),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 118, 67),
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${widget.orderItem.finalPrice}€     "),
                                    TextSpan(
                                      text: "x${widget.orderItem.quantity}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CheckoutCard extends StatefulWidget {
  Order orderObj;
  double total;
  CheckoutCard({Key? key, required this.total, required this.orderObj})
      : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  late OrderProvider _orderProvider;
  @override
  void initState() {
    super.initState();
    _orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.string(receiptIcon),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    print("BTN - CANCEL order");

                    var obj = await _orderProvider
                        .deleteOrderAndCoupon(widget.orderObj.id!);

                    showFailPopup(context, "Order Canceled!");

                    Future.delayed(const Duration(milliseconds: 600), () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 150),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ShoppingCartScreen(),
                        ),
                      );
                    });
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child: Row(
                    children: [
                      const Text("Cancel order"),
                      SizedBox(width: 5),
                      Icon(
                        Icons.cancel_rounded,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "${widget.total}€",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (widget.orderObj.orderItems?.length == 0)
                        ? null // disables the button if no items
                        : () async {
                            print("CONFIRM Method CALL");

                            var obj = await _orderProvider.confirmOrder(
                                widget.orderObj.id!,
                                LoginResponse
                                    .currentCustomer!.shoppingCart!.id!);

                            if (obj.newOrder == null) {
                              showSuccessPopup(
                                  context, "Your order is on its way!");
                              setState(() {});
                              Future.delayed(const Duration(milliseconds: 600),
                                  () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 150),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                          opacity: animation, child: child);
                                    },
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ShoppingCartScreen(),
                                  ),
                                );
                              });
                            } else {
                              setState(() {
                                widget.orderObj = obj.newOrder!;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 2000),
                                  content: Text(
                                    "⚠️ Cart updated! Some items changed in price or availability while you were checking out. We've refreshed your order — please review the updated suggestion before confirming again.",
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 158, 158, 158),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 155),
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
                    child: const Text("Confirm"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
