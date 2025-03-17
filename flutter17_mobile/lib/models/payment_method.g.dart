// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      provider: json['provider'] as String?,
      key: json['key'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isDefault: json['isDefault'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'provider': instance.provider,
      'key': instance.key,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'isDefault': instance.isDefault,
      'isDeleted': instance.isDeleted,
    };
