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

  Adress({
    this.id,
    this.street,
    this.city,
    this.country,
    this.postalCode,
    this.isDeleted,
  });

  factory Adress.fromJson(Map<String, dynamic> json) => _$AdressFromJson(json);

  Map<String, dynamic> toJson() => _$AdressToJson(this);
}