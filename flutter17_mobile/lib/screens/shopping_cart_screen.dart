import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/shopping_cart_item_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_provider.dart';
import 'package:flutter17_mobile/screens/no_cart.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late ShoppingCart currentUserShoppingCart;
  late ShoppingCartProvider _shoppingCartProvider;
  late ShoppingCartItemProvider _shoppingCartItemProvider;
  bool isLoading = true;
  double totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shoppingCartProvider = context.read<ShoppingCartProvider>();
    _shoppingCartItemProvider = context.read<ShoppingCartItemProvider>();
    if (LoginResponse.currentCustomer!.shoppingCart != null) {
      initForm();
    } else {
      currentUserShoppingCart = ShoppingCart();
      isLoading = false;
    }
  }

  Future initForm() async {
    var shoppingCartObj = await _shoppingCartProvider
        .getById(LoginResponse.currentCustomer!.shoppingCart!.id!);

    setState(() {
      currentUserShoppingCart = shoppingCartObj;

      if (currentUserShoppingCart.cartItems != null) {
        for (var element in currentUserShoppingCart.cartItems!) {
          element.finalPrice = element.product?.finalPrice;

          totalPrice += element.finalPrice! * element.quantity!;
        }
      }

      isLoading = false;
    });
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
  }

  Future removeItem(int id) async {
    await _shoppingCartItemProvider.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading && currentUserShoppingCart.cartItems != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  const Text(
                    "Your Shopping Cart",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "${currentUserShoppingCart.cartItems?.length ?? 0} items",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: currentUserShoppingCart.cartItems?.length ?? 0,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(currentUserShoppingCart.cartItems![index].id
                        .toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      var deletedItem =
                          currentUserShoppingCart.cartItems![index];

                      Future.delayed(Duration.zero, () {
                        setState(() {
                          totalPrice -= deletedItem.finalPrice!;
                          currentUserShoppingCart.cartItems!.removeAt(index);
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
                    child: CartCard(
                        cartItem: currentUserShoppingCart.cartItems![index]),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CheckoutCard(
              total: totalPrice,
            ),
          )
        : !isLoading
            ? NoCartScreen()
            : LoadingScreen();
  }
}

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  String imageToShow = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imageToShow = widget.cartItem.product!.productImages!
        .where((element) =>
            element.productColor!.id == widget.cartItem.productColorId)
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
                    selectedProduct: widget.cartItem.product!,
                    selectedProductColor123: widget.cartItem.productColor,
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
              Text(
                "${widget.cartItem.product!.brand!} ${widget.cartItem.product!.model!}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.cartItem.product!.finalPrice ==
                          widget.cartItem.product!.price
                      ? RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 118, 67),
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "${widget.cartItem.product!.finalPrice}€     "),
                              TextSpan(
                                text: "x${widget.cartItem.quantity}",
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
                                "${widget.cartItem.product!.price}€",
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
                                    color: Color.fromARGB(
                                        255, 255, 118, 67), // default color
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${widget.cartItem.product!.finalPrice}€     "),
                                    TextSpan(
                                      text: "x${widget.cartItem.quantity}",
                                      style: const TextStyle(
                                        color: Colors
                                            .grey, // <- different color for quantity
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

class CheckoutCard extends StatelessWidget {
  double total;
  CheckoutCard({Key? key, required this.total}) : super(key: key);

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
                  onPressed: () {
                    print("BTN - Add coupon code");
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child: Row(
                    children: [
                      const Text("Add coupon code"),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
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
                          text: "${total}€",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("BTN - Check Out - ${total}€");
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
                    child: const Text("Check Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
