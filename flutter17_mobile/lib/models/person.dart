import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  int? id;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;

  Person({
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
