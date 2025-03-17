import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accessory_category.g.dart';

@JsonSerializable()
class AccessoryCategory {
  int? id;
  String? name;  
  bool? isDeleted;

  AccessoryCategory({
    this.id,
    this.name,
    this.isDeleted,
  });

  factory AccessoryCategory.fromJson(Map<String, dynamic> json) =>
      _$AccessoryCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AccessoryCategoryToJson(this);
}