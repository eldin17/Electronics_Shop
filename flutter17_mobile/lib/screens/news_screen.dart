import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/news.dart' as Model;
import 'package:flutter17_mobile/providers/news_provider.dart';
import 'package:flutter17_mobile/screens/news_details_screen.dart';
import 'package:flutter17_mobile/widgets/discount.dart';
import 'package:flutter17_mobile/widgets/section_title.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Model.News> newsList = [];
  late NewsProvider _newsProvider;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsProvider = context.read<NewsProvider>();

    initForm();
  }

  Future initForm() async {
    var newsObj = await _newsProvider
        .getAll(filter: {"pageNumber": 1, "itemsPerPage": 10});

    setState(() {
      newsList = List<Model.News>.from(newsObj.data);

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
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
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                newsList.length < 10 ? newsList.length : 10,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LargeNewsCard(
                      image: 'assets/images/background${index + 1}.jpg',
                      category: newsList[index].title ?? "No Data",
                      datePosted:
                          newsList[index].datePublished ?? DateTime.now(),
                      press: () {
                        Navigator.of(context).push(
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
                                    NewsDetailsScreen(
                              news: newsList[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeNewsCard extends StatelessWidget {
  const LargeNewsCard({
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
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 320,
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
