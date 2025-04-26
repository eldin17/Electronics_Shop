import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/customer.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter17_mobile/models/image.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  int? id;
  int? rating;
  String? comment;
  Customer? customer;
  int? productId;
  Image? image;
  
  Review({
    this.id,
    this.rating,
    this.comment,
    this.customer,
    this.productId,
    this.image,
  });

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}