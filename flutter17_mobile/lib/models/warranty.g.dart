// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Warranty _$WarrantyFromJson(Map<String, dynamic> json) => Warranty(
      id: (json['id'] as num?)?.toInt(),
      period_mm: (json['period_mm'] as num?)?.toInt(),
      coverageDetails: json['coverageDetails'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WarrantyToJson(Warranty instance) => <String, dynamic>{
      'id': instance.id,
      'period_mm': instance.period_mm,
      'coverageDetails': instance.coverageDetails,
      'productId': instance.productId,
    };
