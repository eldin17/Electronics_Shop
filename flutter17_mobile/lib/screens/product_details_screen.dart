import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/product_color.dart';
import 'package:flutter17_mobile/models/product_image.dart';
import 'package:flutter17_mobile/providers/wishlist_item_provider.dart';
import 'package:flutter17_mobile/screens/no_wishlist.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  Product selectedProduct;
  ProductDetailsScreen({super.key, required this.selectedProduct});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedColor2 = 0;
  late ProductColor selectedProductColor;
  late List<ProductImage> imageList;
  late WishlistItemProvider _wishlistItemProvider;
  var wishlistItemId = 0;

  @override
  void initState() {
    // TODO: implement initState

    _wishlistItemProvider = context.read<WishlistItemProvider>();
    if (LoginResponse.currentCustomer?.wishlist != null) {
      var obj = LoginResponse.currentCustomer!.wishlist!.wishlistItems?.where(
          (element) => element.product?.id == widget.selectedProduct.id);
      if (obj != null && obj.isNotEmpty) {
        wishlistItemId = obj!.first.id!;
      }
    }

    selectedProductColor =
        widget.selectedProduct.productColors![selectedColor2];

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
              onPressed: () {},
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class ProductImages extends StatefulWidget {
  List<ProductImage> list;
  ProductImages({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  void didUpdateWidget(covariant ProductImages oldWidget) {
    // TODO: implement didUpdateWidget
    selectedImage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Use a linear gradient to create the fading effect towards the bottom
        gradient: LinearGradient(
          begin: Alignment.topCenter, // Fade starts from the top
          end: Alignment.bottomCenter, // Fade ends at the bottom
          colors: [
            Colors.white.withOpacity(1), // Solid color at the top
            Colors.white.withOpacity(0), // Transparent color at the bottom
          ],
          stops: [0.7, 1], // Adjust the fade start point and smoothness
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 238,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                  adjustImage(widget.list[selectedImage].image!.path!)),
            ),
          ),
          // SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                widget.list.length,
                (index) => SmallProductImage(
                  isSelected: index == selectedImage,
                  press: () {
                    setState(() {
                      selectedImage = index;
                    });
                  },
                  image: adjustImage(widget.list[index].image!.path!),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFFFF7643).withOpacity(widget.isSelected ? 1 : 0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 53, 53, 53).withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(0, 4), // Soft drop shadow
            ),
          ],
        ),
        child: Image.network(widget.image),
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

class ColorDots extends StatefulWidget {
  final Product product;
  int selectedColor;
  ValueChanged<ProductColor> changeProductColor;

  ColorDots(
      {super.key,
      required this.product,
      required this.selectedColor,
      required this.changeProductColor});

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int quantity = 1;
  int selectedColorMarker = 0;
  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            widget.product.productColors!.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedColor = index;
                  selectedColorMarker = index;
                });
                print("${widget.product.productColors![index].name}");
                widget.changeProductColor(widget.product.productColors![index]);
              },
              child: ColorDot(
                color:
                    hexToColor(widget.product.productColors![index].hexCode!),
                isSelected: index == selectedColorMarker,
              ),
            ),
          ),
          const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (quantity > 1) quantity--;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "$quantity",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatefulWidget {
  final Color color;
  bool isSelected;

  ColorDot({
    Key? key,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<ColorDot> createState() => _ColorDotState();
}

class _ColorDotState extends State<ColorDot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color: widget.isSelected
                ? const Color(0xFFFF7643)
                : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 10,
              color: const Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
