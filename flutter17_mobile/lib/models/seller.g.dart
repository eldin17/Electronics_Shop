// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
      id: (json['id'] as num?)?.toInt(),
      storename: json['storename'] as String?,
      licenceNumber: (json['licenceNumber'] as num?)?.toInt(),
      adress: json['adress'] == null
          ? null
          : Adress.fromJson(json['adress'] as Map<String, dynamic>),
      userAccountId: (json['userAccountId'] as num?)?.toInt(),
      person: json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'id': instance.id,
      'storename': instance.storename,
      'licenceNumber': instance.licenceNumber,
      'adress': instance.adress,
      'userAccountId': instance.userAccountId,
      'person': instance.person,
      'isDeleted': instance.isDeleted,
    };
