import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod {
  int? id;
  String? type;
  String? provider;
  String? key;
  DateTime? expiryDate;
  bool? isDefault;
  bool? isDeleted;

  PaymentMethod({
    this.id,
    this.type,
    this.provider,
    this.key,
    this.expiryDate,
    this.isDefault,
    this.isDeleted,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
