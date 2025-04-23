import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/product_color.dart';
import 'package:flutter17_mobile/models/product_image.dart';
import 'package:flutter17_mobile/providers/shopping_cart_item_provider.dart';
import 'package:flutter17_mobile/providers/wishlist_item_provider.dart';
import 'package:flutter17_mobile/screens/no_cart.dart';
import 'package:flutter17_mobile/screens/no_wishlist.dart';
import 'package:flutter17_mobile/widgets/color_dots.dart';
import 'package:flutter17_mobile/widgets/product_images.dart';
import 'package:flutter17_mobile/widgets/success.dart';
import 'package:flutter17_mobile/widgets/top_rounded_corner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  Product selectedProduct;
  late ProductColor? selectedProductColor123;
  ProductDetailsScreen(
      {super.key, required this.selectedProduct, this.selectedProductColor123});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedColor2 = 0;
  late ProductColor selectedProductColor;
  late List<ProductImage> imageList;
  late WishlistItemProvider _wishlistItemProvider;
  late ShoppingCartItemProvider _shoppingCartItemProvider;
  var wishlistItemId = 0;
  var quantityInfo = 1;

  @override
  void initState() {
    // TODO: implement initState

    _wishlistItemProvider = context.read<WishlistItemProvider>();
    _shoppingCartItemProvider = context.read<ShoppingCartItemProvider>();

    if (LoginResponse.currentCustomer?.wishlist != null) {
      var obj = LoginResponse.currentCustomer!.wishlist!.wishlistItems?.where(
          (element) => element.product?.id == widget.selectedProduct.id);
      if (obj != null && obj.isNotEmpty) {
        wishlistItemId = obj!.first.id!;
      }
    }

    selectedProductColor = widget.selectedProductColor123 ??
        widget.selectedProduct.productColors![selectedColor2];
    if (widget.selectedProductColor123 != null) {
      for (int i = 0; i < widget.selectedProduct.productColors!.length; i++) {
        if (widget.selectedProduct.productColors![i].id ==
            selectedProductColor.id) selectedColor2 = i;
      }
    }

    // selectedProductColor =
    //     widget.selectedProduct.productColors![selectedColor2];

    imagesColorPickChange();

    print("init ${selectedProductColor.name}");
    print("init ${wishlistItemId}");
  }

  void imagesColorPickChange() {
    imageList = widget.selectedProduct.productImages!.toList();
    imageList = imageList.where(
      (element) {
        return element.productColor!.id == selectedProductColor.id;
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.selectedProduct;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "${product.reviewScoreAvg}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.string(starIcon),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(
            list: imageList,
          ),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  deleteId: wishlistItemId,
                  wishlistItemProvider: _wishlistItemProvider,
                  product: product,
                  pressOnSeeMore: () {
                    print("asvjitwubet");
                  },
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(
                        product: product,
                        selectedColor: selectedColor2,
                        changeProductColor: (value) {
                          setState(() {
                            selectedProductColor = value;
                            imagesColorPickChange();
                            print("setState ${selectedProductColor.name}");
                          });
                        },
                        changeQuantity: (value) {
                          setState(() {
                            quantityInfo = value;

                            print("quantityInfo - ${quantityInfo}");
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFFF7643),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onPressed: () async {
                if (LoginResponse.currentCustomer!.shoppingCart != null) {
                  var cartItemObj = await _shoppingCartItemProvider.add({
                    'quantity': quantityInfo,
                    'productId': widget.selectedProduct.id,
                    'shoppingCartId':
                        LoginResponse.currentCustomer!.shoppingCart!.id,
                    'productColorId': selectedProductColor.id,
                  });

                  if (cartItemObj != null) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       duration: Duration(milliseconds: 500),
                    //         content: Text(
                    //             '${widget.selectedProduct.brand} ${widget.selectedProduct.model} added to Cart!')),
                    //   );
                    showSuccessPopup(context, "Added to Cart!");
                  }
                } else {
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
                          NoCartScreen(
                        productObj: widget.selectedProduct,
                      ),
                    ),
                  );
                }
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  ProductDescription({
    Key? key,
    required this.product,
    required this.wishlistItemProvider,
    required this.deleteId,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;
  final WishlistItemProvider wishlistItemProvider;
  int deleteId;
  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.brand != null && widget.product.model != null
                    ? "${widget.product.brand!}\n${widget.product.model!}"
                    : "No data",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: widget.product.finalPrice == widget.product.price
                    ? Text(
                        "${widget.product.finalPrice}€",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 118, 67),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.product.price}€",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        Color.fromARGB(141, 158, 158, 158),
                                    decorationThickness: 3),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "${widget.product.finalPrice}€",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 118, 67),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              if (LoginResponse.currentCustomer?.wishlist == null) {
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
                        NoWishlistScreen(
                      productObj: widget.product,
                    ),
                  ),
                );
              } else {
                if (widget.product.isFavourite!) {

                  await widget.wishlistItemProvider.delete(widget.deleteId);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Text(
                            'Removed from Wishlist ❌')),
                  );
                } else {
                  var itemObj = await widget.wishlistItemProvider.add({
                    'productId': widget.product.id,
                    'wishlistId': LoginResponse.currentCustomer!.wishlist!.id
                  });
                  setState(() {
                    widget.deleteId = itemObj.id!;
                    LoginResponse.currentCustomer!.wishlist?.wishlistItems
                        ?.add(itemObj);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Text(
                            'Added to Wishlist ❤️')),
                  );
                }

                ;
                setState(() {
                  widget.product.isFavourite = !widget.product.isFavourite!;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 48,
              decoration: BoxDecoration(
                color: widget.product.isFavourite!
                    ? const Color(0xFFFFE6E6)
                    : const Color(0xFFF5F6F9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.string(
                heartIcon2,
                colorFilter: ColorFilter.mode(
                    widget.product.isFavourite!
                        ? const Color(0xFFFF4848)
                        : const Color(0xFFDBDEE4),
                    BlendMode.srcIn),
                height: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            widget.product.description!,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: GestureDetector(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFFFF7643),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
