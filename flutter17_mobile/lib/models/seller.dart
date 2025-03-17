import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  int? id;
  String? storename;
  int? licenceNumber;
  Adress? adress;
  int? userAccountId;
  Person? person;
  bool? isDeleted;

  Seller({
    this.id,
    this.storename,
    this.licenceNumber,
    this.adress,
    this.userAccountId,
    this.person,
    this.isDeleted,
  });

  factory Seller.fromJson(Map<String, dynamic> json) =>
      _$SellerFromJson(json);

  Map<String, dynamic> toJson() => _$SellerToJson(this);
}