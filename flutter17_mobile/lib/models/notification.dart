import 'package:flutter17_mobile/models/user_notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  int? id;
  String? title;
  String? message;
  DateTime? dateCreated;
  bool? isGeneral;
  List<UserNotification>? userNotification;

  Notification({
    this.id,
    this.title,
    this.message,
    this.dateCreated,
    this.isGeneral,
    this.userNotification,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}