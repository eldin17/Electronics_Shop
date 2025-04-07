import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/news.dart' as Model;
import 'package:flutter17_mobile/screens/news_details_screen.dart';
import 'package:flutter17_mobile/screens/news_screen.dart';
import 'package:flutter17_mobile/widgets/discount.dart';
import 'package:flutter17_mobile/widgets/section_title.dart';

class News extends StatelessWidget {
  final List<Model.News> list;
  News({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            showSeeMore: true,
            title: "News",
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
                      NewsScreen(),
                ),
              );
              print("News See More");
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                list.length < 4 ? list.length : 4,
                (index) {
                  return SpecialOfferCard(
                    image: 'assets/images/background${index + 1}.jpg',
                    category: list[index].title ?? "No Data",
                    numOfBrands: 18,
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  NewsDetailsScreen(
                            news: list[index],
                          ),
                        ),
                      );
                    },
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
