import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/screens/products_screen.dart';
import 'package:flutter17_mobile/widgets/product_card.dart';
import 'package:flutter17_mobile/widgets/section_title.dart';

class LatestProducts extends StatefulWidget {
  List<Product> products;
  LatestProducts({super.key, required this.products});

  @override
  State<LatestProducts> createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            showSeeMore: true,
            title: "Latest Products",
            press: () {
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
                        ProductsScreen(
                          fromLatest: true,
                        )),
              );
              print("Latest See More");
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                widget.products.length < 4 ? widget.products.length : 4,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ProductCard(
                        align: Alignment.bottomRight,
                        product: widget.products[index],
                        onPress: () {
                          print(widget.products[index].brand);
                          print(
                              "favourite: ${widget.products[index].isFavourite}");
                          print(
                              "review: ${widget.products[index].reviewScoreAvg}");
                          Navigator.of(context)
                              .push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 150),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ProductDetailsScreen(
                                selectedProduct: widget.products[index],
                              ),
                            ),
                          )
                              .then((_) {
                            setState(() {});
                          });
                        }),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}