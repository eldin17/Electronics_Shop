// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSuggestion _$OrderSuggestionFromJson(Map<String, dynamic> json) =>
    OrderSuggestion(
      oldOrder: json['oldOrder'] == null
          ? null
          : Order.fromJson(json['oldOrder'] as Map<String, dynamic>),
      newOrder: json['newOrder'] == null
          ? null
          : Order.fromJson(json['newOrder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderSuggestionToJson(OrderSuggestion instance) =>
    <String, dynamic>{
      'oldOrder': instance.oldOrder,
      'newOrder': instance.newOrder,
    };
