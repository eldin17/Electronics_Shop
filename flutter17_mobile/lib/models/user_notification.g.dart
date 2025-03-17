// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      id: (json['id'] as num?)?.toInt(),
      userAccountId: (json['userAccountId'] as num?)?.toInt(),
      notificationId: (json['notificationId'] as num?)?.toInt(),
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userAccountId': instance.userAccountId,
      'notificationId': instance.notificationId,
      'isRead': instance.isRead,
    };
