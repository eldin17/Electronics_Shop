// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_pw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPW _$ResetPWFromJson(Map<String, dynamic> json) => ResetPW(
      userAccId: (json['userAccId'] as num?)?.toInt(),
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ResetPWToJson(ResetPW instance) => <String, dynamic>{
      'userAccId': instance.userAccId,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
