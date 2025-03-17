// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessory_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessoryProperty _$AccessoryPropertyFromJson(Map<String, dynamic> json) =>
    AccessoryProperty(
      id: (json['id'] as num?)?.toInt(),
      propertyName: json['propertyName'] as String?,
      propertyValue: json['propertyValue'] as String?,
    );

Map<String, dynamic> _$AccessoryPropertyToJson(AccessoryProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyName': instance.propertyName,
      'propertyValue': instance.propertyValue,
    };
