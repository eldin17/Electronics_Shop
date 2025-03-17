import 'package:json_annotation/json_annotation.dart';

part 'user_notification.g.dart';

@JsonSerializable()
class UserNotification {
  int? id;
  int? userAccountId;
  int? notificationId;  
  bool? isRead;

  UserNotification({
    this.id,
    this.userAccountId,
    this.notificationId,
    this.isRead,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) => _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}