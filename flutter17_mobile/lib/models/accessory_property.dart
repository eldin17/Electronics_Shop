import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accessory_property.g.dart';

@JsonSerializable()
class AccessoryProperty {
  int? id;
  String? propertyName;
  String? propertyValue;

  AccessoryProperty({
    this.id,
    this.propertyName,
    this.propertyValue,
  });

  factory AccessoryProperty.fromJson(Map<String, dynamic> json) =>
      _$AccessoryPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$AccessoryPropertyToJson(this);
}