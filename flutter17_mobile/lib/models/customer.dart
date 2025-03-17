import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  int? id;
  int? loyaltyPoints;
  int? userAccountId;
  List<Adress>? adresses;
  Wishlist? wishlist;
  List<PaymentMethod>? paymentMethods;
  Person? person;
  bool? isDeleted;

  Customer({
    this.id,
    this.loyaltyPoints,
    this.userAccountId,
    this.adresses,
    this.wishlist,
    this.paymentMethods,
    this.person,
    this.isDeleted,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}