import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/review.dart';
import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/reviews_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_item_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_provider.dart';
import 'package:flutter17_mobile/screens/no_cart.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter17_mobile/widgets/star_rating.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatefulWidget {
  Product product;
  ReviewsScreen({super.key, required this.product});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late List<Review> reviewsList;
  late ReviewsProvider _reviewsProvider;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewsProvider = context.read<ReviewsProvider>();
    initForm();
  }

  Future initForm() async {
    var reviewsObj =
        await _reviewsProvider.getAll(filter: {'productId': widget.product.id});

    setState(() {
      reviewsList = List<Review>.from(reviewsObj.data);

      reviewsList.sort((a, b) => b.id!.compareTo(a.id!));

      isLoading = false;
    });

    print("reviews - ${reviewsList.length}");
    for (var element in reviewsList) {
      print("comment - ${element.comment}");
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "User Reviews",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "${widget.product.brand} ${widget.product.model}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
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
                          widget.product.reviewScoreAvg!.toStringAsFixed(1),
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
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: reviewsList.length ?? 0,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      ReviewCard(reviewItem: reviewsList[index]),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Color.fromARGB(166, 241, 241, 241),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: LeaveReviewCard(
              reviewsProvider: _reviewsProvider,
              productId: widget.product.id!,
              function: initForm,
            ),
          )
        : !isLoading
            ? NoCartScreen()
            : LoadingScreen();
  }
}

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    Key? key,
    required this.reviewItem,
  }) : super(key: key);

  final Review reviewItem;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //OPEN REVIEW DETAILS (BOTTOM MODAL)
        print("score - ${widget.reviewItem.rating}");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 68,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(201, 122, 122, 122).withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: widget.reviewItem.image?.path != null
                        ? Image.network(
                            adjustImage(widget.reviewItem.image!.path!),
                            fit: BoxFit.cover,
                          )
                        : Placeholder(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.reviewItem.customer?.person?.firstName} ${widget.reviewItem.customer?.person?.lastName}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  reviewStars(widget.reviewItem.rating!),
                  const SizedBox(height: 8),
                  Text(
                    widget.reviewItem.comment ?? '',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewStars(int score) {
    List<Widget> list = [];
    for (var i = 0; i < score; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: SvgPicture.string(
            starIcon,
          ),
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}

class LeaveReviewCard extends StatelessWidget {
  LeaveReviewCard(
      {Key? key,
      required this.reviewsProvider,
      required this.productId,
      required this.function})
      : super(key: key);
  final TextEditingController _commentController = TextEditingController();
  int productId;
  ReviewsProvider reviewsProvider;
  VoidCallback function;

  var selectedRating = 0;
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
            color: Color.fromARGB(255, 66, 66, 66).withOpacity(0.15),
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
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.string(reviewIcon),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Container(
                    width: 150,
                    height: 60,
                    child: FormBuilderTextField(
                      name: 'comment',
                      controller: _commentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Leave a comment';
                        }
                      },
                      textInputAction: TextInputAction.newline,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Comment",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(209, 117, 117, 117),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        border: authOutlineInputBorder,
                        enabledBorder: authOutlineInputBorder,
                        focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Color(0xFFFF7643)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: StarRating(
                    onRatingChanged: (rating) {
                      print("User selected $rating stars");
                      selectedRating = rating;
                    },
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      print("BTN - Post Review");

                      if (_commentController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content: Text(
                                "Oops! You forgot to say something 📝"),
                            backgroundColor: Color.fromARGB(255, 158, 158, 158),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 170),
                          ),
                        );
                        return;
                      }

                      if (selectedRating == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content: Text(
                                "Pick some stars ⭐️⭐️⭐️ – we need your rating!"),
                            backgroundColor: Color.fromARGB(255, 158, 158, 158),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 155),
                          ),
                        );
                        return;
                      }

                      var reviewObj = await reviewsProvider.add({
                        'rating': selectedRating,
                        'comment': _commentController.text,
                        'customerId': LoginResponse.currentCustomer!.id,
                        'productId': productId
                      });

                      function();
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
                    child: const Text("Post Review"),
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

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);
