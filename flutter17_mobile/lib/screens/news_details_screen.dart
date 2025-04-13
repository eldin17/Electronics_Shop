import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/news.dart' as Model;

class NewsDetailsScreen extends StatefulWidget {
  final Model.News news;

  const NewsDetailsScreen({super.key, required this.news});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 231, 231, 231),
                Color(0xFFFFFFFF),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeText(
                    title: "${widget.news.title ?? ''}",
                    text: "${widget.news.content ?? ''}",
                    datePosted: widget.news.datePublished ?? DateTime.now(),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7643),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  final String title, text;
  final DateTime datePosted;

  WelcomeText(
      {super.key,
      required this.title,
      required this.text,
      required this.datePosted});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                foreground: Paint()
                  ..style = PaintingStyle.fill
                  ..strokeWidth = 1
                  ..color = const Color(0xFFFF7643),
              ),
        ),
        const SizedBox(height: 16),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 60),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "Posted ${getTimeAgo(datePosted) ?? ''}",
            style: TextStyle(
              color: const Color.fromARGB(255, 107, 107, 107),
            ),
          ),
        ),
      ],
    );
  }
}
