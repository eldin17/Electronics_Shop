import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:flutter17_mobile/models/wishlist_item.dart';
import 'package:flutter17_mobile/providers/wishlist_item_provider.dart';
import 'package:flutter17_mobile/providers/wishlist_provider.dart';
import 'package:flutter17_mobile/screens/no_wishlist.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late Wishlist currentUserWishlist;
  late WishlistProvider _wishlistProvider;
  late WishlistItemProvider _wishlistItemProvider;
  bool isLoading = true;

  void refreshScreenTest() {
    initForm();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wishlistProvider = context.read<WishlistProvider>();
    _wishlistItemProvider = context.read<WishlistItemProvider>();
    initForm();
  }

  Future initForm() async {
    var wishlistObj = await _wishlistProvider
        .getById(LoginResponse.currentCustomer!.wishlist!.id!);

    setState(() {
      currentUserWishlist = wishlistObj;

      isLoading = false;
    });
  }

  Future removeItem(int id) async {
    await _wishlistItemProvider.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading && currentUserWishlist.wishlistItems != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  const Text(
                    "Your Wishlist",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "${currentUserWishlist.wishlistItems?.length ?? 0} items",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: currentUserWishlist.wishlistItems?.length ?? 0,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(currentUserWishlist
                        .wishlistItems![index].product!.id
                        .toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      removeItem(currentUserWishlist.wishlistItems![index].id!);

                      setState(() {
                        currentUserWishlist
                            .wishlistItems![index].product!.isFavourite = false;
                        currentUserWishlist.wishlistItems?.removeAt(index);
                      });
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
                    child: ItemCard(
                        item: currentUserWishlist.wishlistItems![index]),
                  ),
                ),
              ),
            ),
          )
        : !isLoading
            ? NoWishlistScreen()
            : LoadingScreen();
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final WishlistItem item;

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
                    selectedProduct: item.product!,
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
                  adjustImage(item.product!.productImages![0].image!.path!),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.product!.brand!} ${item.product!.model!}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  item.product!.finalPrice == item.product!.price
                      ? Text(
                          "${item.product!.finalPrice}€",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 118, 67),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${item.product!.price}€",
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
                              Text(
                                "${item.product!.finalPrice}€",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 118, 67),
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
