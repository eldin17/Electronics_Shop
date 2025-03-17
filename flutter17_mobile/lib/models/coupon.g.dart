// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      discountAmount: (json['discountAmount'] as num?)?.toInt(),
      minPurchaseAmount: (json['minPurchaseAmount'] as num?)?.toInt(),
      maxUsagePerCustomer: (json['maxUsagePerCustomer'] as num?)?.toInt(),
      productCategoryId: (json['productCategoryId'] as num?)?.toInt(),
      accessoryCategoryId: (json['accessoryCategoryId'] as num?)?.toInt(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'discountAmount': instance.discountAmount,
      'minPurchaseAmount': instance.minPurchaseAmount,
      'maxUsagePerCustomer': instance.maxUsagePerCustomer,
      'productCategoryId': instance.productCategoryId,
      'accessoryCategoryId': instance.accessoryCategoryId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'isDeleted': instance.isDeleted,
    };
