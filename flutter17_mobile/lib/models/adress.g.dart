// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adress _$AdressFromJson(Map<String, dynamic> json) => Adress(
      id: (json['id'] as num?)?.toInt(),
      street: json['street'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$AdressToJson(Adress instance) => <String, dynamic>{
      'id': instance.id,
      'street': instance.street,
      'city': instance.city,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'isDeleted': instance.isDeleted,
    };
