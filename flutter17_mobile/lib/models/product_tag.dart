import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_tag.g.dart';

@JsonSerializable()
class ProductTag {
  int? id;
  String? tag;
  
  ProductTag({
    this.id,
    this.tag,    
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) =>
      _$ProductTagFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTagToJson(this);
}