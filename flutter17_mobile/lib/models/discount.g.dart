// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      id: (json['id'] as num?)?.toInt(),
      discountType: json['discountType'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
      productDiscounts: (json['productDiscounts'] as List<dynamic>?)
          ?.map((e) => ProductDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
      notAppliedList: (json['notAppliedList'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'id': instance.id,
      'discountType': instance.discountType,
      'amount': instance.amount,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'productDiscounts': instance.productDiscounts,
      'notAppliedList': instance.notAppliedList,
    };
