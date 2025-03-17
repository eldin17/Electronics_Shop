import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warranty.g.dart';

@JsonSerializable()
class Warranty {
  int? id;
  int? period_mm;
  String? coverageDetails;
  int? productId;
  
  Warranty({
    this.id,
    this.period_mm,
    this.coverageDetails,
    this.productId,
  });

  factory Warranty.fromJson(Map<String, dynamic> json) =>
      _$WarrantyFromJson(json);

  Map<String, dynamic> toJson() => _$WarrantyToJson(this);
}