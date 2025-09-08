// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_del.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayMethDel _$PayMethDelFromJson(Map<String, dynamic> json) => PayMethDel(
      customerId: (json['customerId'] as num?)?.toInt(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PayMethDelToJson(PayMethDel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'type': instance.type,
    };
