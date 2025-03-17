// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTag _$ProductTagFromJson(Map<String, dynamic> json) => ProductTag(
      id: (json['id'] as num?)?.toInt(),
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$ProductTagToJson(ProductTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
    };
