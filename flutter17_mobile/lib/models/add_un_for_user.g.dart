// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_un_for_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationForUser _$AddNotificationForUserFromJson(
        Map<String, dynamic> json) =>
    AddNotificationForUser(
      title: json['title'] as String?,
      message: json['message'] as String?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      isGeneral: json['isGeneral'] as bool?,
      userAccIds: (json['userAccIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$AddNotificationForUserToJson(
        AddNotificationForUser instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'isGeneral': instance.isGeneral,
      'userAccIds': instance.userAccIds,
    };
