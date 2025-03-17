// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accessory _$AccessoryFromJson(Map<String, dynamic> json) => Accessory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
      accessoryCategory: json['accessoryCategory'] == null
          ? null
          : AccessoryCategory.fromJson(
              json['accessoryCategory'] as Map<String, dynamic>),
      accessoryProperties: (json['accessoryProperties'] as List<dynamic>?)
          ?.map((e) => AccessoryProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccessoryToJson(Accessory instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'productId': instance.productId,
      'accessoryCategory': instance.accessoryCategory?.toJson(),
      'accessoryProperties':
          instance.accessoryProperties?.map((e) => e.toJson()).toList(),
    };
