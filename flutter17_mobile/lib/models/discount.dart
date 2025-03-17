import 'package:flutter17_mobile/models/accessory.dart';
import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/camera.dart';
import 'package:flutter17_mobile/models/desktopPC.dart';
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

part 'discount.g.dart';

@JsonSerializable()
class Discount {
  int? id;
  String? discountType;
  int? amount;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  List<ProductDiscount>? productDiscounts;
  List<Product>? notAppliedList;
  
  Discount({    
    this.id,
    this.discountType,
    this.amount,
    this.startDate,
    this.endDate,
    this.isActive,
    this.productDiscounts,
    this.notAppliedList,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}