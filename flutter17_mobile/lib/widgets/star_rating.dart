import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRating extends StatefulWidget {
  final void Function(int rating) onRatingChanged;

  const StarRating({Key? key, required this.onRatingChanged}) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = starIndex;
            });
            widget.onRatingChanged(_currentRating);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _currentRating >= starIndex
                ? SvgPicture.string(
                    starIcon2, 
                    height: 18,
                    width: 18,
                  )
                : SvgPicture.string(
                    starIcon2empty, 
                    height: 18,
                    width: 18,
                  ),
          ),
        );
      }),
    );
  }
}
