// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessory_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessoryCategory _$AccessoryCategoryFromJson(Map<String, dynamic> json) =>
    AccessoryCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$AccessoryCategoryToJson(AccessoryCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isDeleted': instance.isDeleted,
    };
