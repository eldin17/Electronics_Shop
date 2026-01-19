// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      orderTime: json['orderTime'] == null
          ? null
          : DateTime.parse(json['orderTime'] as String),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      finalTotalAmount: (json['finalTotalAmount'] as num?)?.toDouble(),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      adress: json['adress'] == null
          ? null
          : Adress.fromJson(json['adress'] as Map<String, dynamic>),
      coupon: json['coupon'] == null
          ? null
          : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
      stateMachine: json['stateMachine'] as String?,
      couponId: (json['couponId'] as num?)?.toInt(),
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethod.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'orderTime': instance.orderTime?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'finalTotalAmount': instance.finalTotalAmount,
      'customer': instance.customer,
      'adress': instance.adress,
      'coupon': instance.coupon,
      'couponId': instance.couponId,
      'stateMachine': instance.stateMachine,
      'paymentMethod': instance.paymentMethod,
      'orderItems': instance.orderItems,
    };
