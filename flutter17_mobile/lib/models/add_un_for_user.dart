import 'package:json_annotation/json_annotation.dart';

part 'add_un_for_user.g.dart';

@JsonSerializable()
class AddNotificationForUser {
  String? title;
  String? message;
  DateTime? dateCreated;
  bool? isGeneral;
  List<int>? userAccIds;

  AddNotificationForUser({
    this.title,
    this.message,
    this.dateCreated,
    this.isGeneral,
    this.userAccIds,
  });

  factory AddNotificationForUser.fromJson(Map<String, dynamic> json) => _$AddNotificationForUserFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationForUserToJson(this);
}