import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/discount.dart';

class DiscountBanner extends StatelessWidget {
  Discount? obj;
  DiscountBanner({
    Key? key,
    this.obj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: obj != null
                  ? "💥 Something special is waiting below!\n"
                  : "🎁 A Special Surprise Just for You!\n",
            ),
            TextSpan(
              text: obj != null
                  ? "🔥 Save ${obj!.amount}€ on select items!"
                  : "🛍️ Dive into amazing discounts!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SpecialOfferCard extends StatelessWidget {
//   const SpecialOfferCard({
//     Key? key,
//     required this.category,
//     required this.image,
//     required this.datePosted,
//     required this.press,
//   }) : super(key: key);

//   final String category, image;
//   final DateTime datePosted;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20),
//       child: GestureDetector(
//         onTap: press,
//         child: SizedBox(
//           width: 242,
//           height: 100,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: Image(
//                     image: AssetImage(image),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black54,
//                         Colors.black38,
//                         Colors.black26,
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                     Text(
//                       "$category",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       getTimeAgo(datePosted) ?? '',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
