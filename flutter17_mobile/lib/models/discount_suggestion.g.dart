// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountSuggestion _$DiscountSuggestionFromJson(Map<String, dynamic> json) =>
    DiscountSuggestion(
      oldDiscount: json['oldDiscount'] == null
          ? null
          : Discount.fromJson(json['oldDiscount'] as Map<String, dynamic>),
      newDiscount: json['newDiscount'] == null
          ? null
          : Discount.fromJson(json['newDiscount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscountSuggestionToJson(DiscountSuggestion instance) =>
    <String, dynamic>{
      'oldDiscount': instance.oldDiscount,
      'newDiscount': instance.newDiscount,
    };
