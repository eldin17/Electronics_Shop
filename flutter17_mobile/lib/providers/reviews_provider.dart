import 'package:flutter17_mobile/models/review.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class ReviewsProvider extends BaseCRUDProvider<Review> {

  ReviewsProvider() : super("api/Review") ;

  @override
  Review fromJson(data){
    return Review.fromJson(data);
  }
}