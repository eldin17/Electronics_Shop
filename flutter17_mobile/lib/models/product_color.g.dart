// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductColor _$ProductColorFromJson(Map<String, dynamic> json) => ProductColor(
      id: (json['id'] as num?)?.toInt(),
      productImageId: (json['productImageId'] as num?)?.toInt(),
      name: json['name'] as String?,
      hexCode: json['hexCode'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductColorToJson(ProductColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productImageId': instance.productImageId,
      'name': instance.name,
      'hexCode': instance.hexCode,
      'stock': instance.stock,
    };
