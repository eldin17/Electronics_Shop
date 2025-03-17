// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      roleId: (json['roleId'] as num?)?.toInt(),
      imageId: (json['imageId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'roleId': instance.roleId,
      'imageId': instance.imageId,
    };
