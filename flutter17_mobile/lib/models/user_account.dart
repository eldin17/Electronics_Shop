import 'package:flutter17_mobile/models/customer.dart';
import 'package:flutter17_mobile/models/image.dart';
import 'package:flutter17_mobile/models/role.dart';
import 'package:flutter17_mobile/models/seller.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount {
  int? id;
  String? username;
  String? email;
  DateTime? registrationDate;
  Customer? customer;
  Seller? seller;
  Role? role;
  Image? image;
  bool? isDeactivated;

  UserAccount({
    this.id,
    this.username,
    this.email,
    this.registrationDate,
    this.customer,
    this.seller,
    this.role,
    this.image,
    this.isDeactivated,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
