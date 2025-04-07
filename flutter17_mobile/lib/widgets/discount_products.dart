import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/screens/products_screen.dart';
import 'package:flutter17_mobile/widgets/product_card.dart';
import 'package:flutter17_mobile/widgets/section_title.dart';

class DiscountProducts extends StatelessWidget {
  List<Product> products;

  DiscountProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            showSeeMore: true,
            title: "On Discount",
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
                          fromOnDiscount: true,
                        )),
              );
              print("Discount See More");
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                products.length < 4 ? products.length : 4,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ProductCard(
                      align: Alignment.bottomRight,
                      product: products[index],
                      onPress: () {
                        print(products[index].brand);
                      },
                    ),
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
