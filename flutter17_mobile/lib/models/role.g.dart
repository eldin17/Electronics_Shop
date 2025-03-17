// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: (json['id'] as num?)?.toInt(),
      roleName: json['roleName'] as String?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'roleName': instance.roleName,
      'isDeleted': instance.isDeleted,
    };
