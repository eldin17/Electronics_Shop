import 'package:flutter17_mobile/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_suggestion.g.dart';

@JsonSerializable()
class OrderSuggestion {
  String? sessionId;
  Order? oldOrder;
  Order? newOrder;
 

  OrderSuggestion({
    this.sessionId,
    this.oldOrder,
    this.newOrder,   
  });

  factory OrderSuggestion.fromJson(Map<String, dynamic> json) => _$OrderSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSuggestionToJson(this);
}