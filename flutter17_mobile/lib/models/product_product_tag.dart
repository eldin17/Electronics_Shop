import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/product_tag.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_product_tag.g.dart';

@JsonSerializable()
class ProductProductTag {
  int? id;
  ProductTag? productTag;  

  ProductProductTag({
    this.id,
    this.productTag,   
  });

  factory ProductProductTag.fromJson(Map<String, dynamic> json) =>
      _$ProductProductTagFromJson(json);

  Map<String, dynamic> toJson() => _$ProductProductTagToJson(this);
}