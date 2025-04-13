import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/news.dart' as Model;
import 'package:flutter17_mobile/screens/news_details_screen.dart';
import 'package:flutter17_mobile/screens/news_screen.dart';
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
                  return NewsCard(
                    image: 'assets/images/background${index + 1}.jpg',
                    category: list[index].title ?? "No Data",
                    datePosted: list[index].datePublished ?? DateTime.now(),
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
class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.category,
    required this.image,
    required this.datePosted,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final DateTime datePosted;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      "$category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getTimeAgo(datePosted) ?? '',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
