import 'package:json_annotation/json_annotation.dart';

part 'adress.g.dart';

@JsonSerializable()
class Adress {
  int? id;
  String? street;
  String? city;
  String? country;
  String? postalCode;
  bool? isDeleted;
  int? customerId;
  int? personId;


  Adress({
    this.id,
    this.street,
    this.city,
    this.country,
    this.postalCode,
    this.isDeleted,
    this.customerId,
    this.personId,
  });

  factory Adress.fromJson(Map<String, dynamic> json) => _$AdressFromJson(json);

  Map<String, dynamic> toJson() => _$AdressToJson(this);
}