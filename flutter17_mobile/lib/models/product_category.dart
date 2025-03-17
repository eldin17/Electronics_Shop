import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  int? id;
  String? name;  
  bool? isDeleted;

  ProductCategory({
    this.id,
    this.name,
    this.isDeleted,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}