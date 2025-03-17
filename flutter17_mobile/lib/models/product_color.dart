import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_color.g.dart';

@JsonSerializable()
class ProductColor {
  int? id;
  int? productImageId;
  String? name;
  String? hexCode;
  int? stock;

  ProductColor({
    this.id,
    this.productImageId,
    this.name,
    this.hexCode,
    this.stock,   
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) =>
      _$ProductColorFromJson(json);

  Map<String, dynamic> toJson() => _$ProductColorToJson(this);
}