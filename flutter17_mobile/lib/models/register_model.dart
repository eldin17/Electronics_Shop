import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  String? username;
  String? email;
  String? password;
  int? roleId;
  int? imageId;
  

  RegisterModel({
    this.username,
    this.email,
    this.password,
    this.roleId,
    this.imageId,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}