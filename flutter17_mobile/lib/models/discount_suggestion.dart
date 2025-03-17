import 'package:flutter17_mobile/models/accessory.dart';
import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/camera.dart';
import 'package:flutter17_mobile/models/desktopPC.dart';
import 'package:flutter17_mobile/models/discount.dart';
import 'package:flutter17_mobile/models/gaming_console.dart';
import 'package:flutter17_mobile/models/laptop.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/phone.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/product_category.dart';
import 'package:flutter17_mobile/models/product_color.dart';
import 'package:flutter17_mobile/models/product_discount.dart';
import 'package:flutter17_mobile/models/product_image.dart';
import 'package:flutter17_mobile/models/product_product_tag.dart';
import 'package:flutter17_mobile/models/review.dart';
import 'package:flutter17_mobile/models/tablet.dart';
import 'package:flutter17_mobile/models/television.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/warranty.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount_suggestion.g.dart';

@JsonSerializable()
class DiscountSuggestion {
  Discount? oldDiscount;
  Discount? newDiscount;  
  
  DiscountSuggestion({    
    this.oldDiscount,
    this.newDiscount,    
  });

  factory DiscountSuggestion.fromJson(Map<String, dynamic> json) =>
      _$DiscountSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountSuggestionToJson(this);
}