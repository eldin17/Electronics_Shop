// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerCoupon _$CustomerCouponFromJson(Map<String, dynamic> json) =>
    CustomerCoupon(
      id: (json['id'] as num?)?.toInt(),
      customerid: (json['customerid'] as num?)?.toInt(),
      couponId: (json['couponId'] as num?)?.toInt(),
      usageCount: (json['usageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomerCouponToJson(CustomerCoupon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerid': instance.customerid,
      'couponId': instance.couponId,
      'usageCount': instance.usageCount,
    };
