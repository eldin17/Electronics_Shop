import 'package:json_annotation/json_annotation.dart';

part 'payment_method_del.g.dart';

@JsonSerializable()
class PayMethDel {
  int? customerId;
  String? type;
  

  PayMethDel({
    this.customerId,
    this.type,
  });

  factory PayMethDel.fromJson(Map<String, dynamic> json) =>
      _$PayMethDelFromJson(json);

  Map<String, dynamic> toJson() => _$PayMethDelToJson(this);
}