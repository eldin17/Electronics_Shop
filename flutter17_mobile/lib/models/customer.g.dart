// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: (json['id'] as num?)?.toInt(),
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt(),
      userAccountId: (json['userAccountId'] as num?)?.toInt(),
      adresses: (json['adresses'] as List<dynamic>?)
          ?.map((e) => Adress.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlist: json['wishlist'] == null
          ? null
          : Wishlist.fromJson(json['wishlist'] as Map<String, dynamic>),
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      person: json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'loyaltyPoints': instance.loyaltyPoints,
      'userAccountId': instance.userAccountId,
      'adresses': instance.adresses,
      'wishlist': instance.wishlist,
      'paymentMethods': instance.paymentMethods,
      'person': instance.person,
      'isDeleted': instance.isDeleted,
    };
