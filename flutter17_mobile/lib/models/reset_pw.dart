import 'package:json_annotation/json_annotation.dart';

part 'reset_pw.g.dart';

@JsonSerializable()
class ResetPW {
  int? userAccId;
  String? oldPassword;
  String? newPassword;
  

  ResetPW({
    this.userAccId,
    this.oldPassword,
    this.newPassword,
  });

  factory ResetPW.fromJson(Map<String, dynamic> json) =>
      _$ResetPWFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPWToJson(this);
}