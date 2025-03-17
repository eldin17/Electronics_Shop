// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_product_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductProductTag _$ProductProductTagFromJson(Map<String, dynamic> json) =>
    ProductProductTag(
      id: (json['id'] as num?)?.toInt(),
      productTag: json['productTag'] == null
          ? null
          : ProductTag.fromJson(json['productTag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductProductTagToJson(ProductProductTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productTag': instance.productTag,
    };
