// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Camera _$CameraFromJson(Map<String, dynamic> json) => Camera(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      megapixels: (json['megapixels'] as num?)?.toDouble(),
      sensorType: json['sensorType'] as String?,
      lensMount: json['lensMount'] as String?,
      videoResolution: json['videoResolution'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      hasWiFi: json['hasWiFi'] as bool?,
      hasBluetooth: json['hasBluetooth'] as bool?,
      batteryType: json['batteryType'] as String?,
      batteryLife: (json['batteryLife'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CameraToJson(Camera instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'megapixels': instance.megapixels,
      'sensorType': instance.sensorType,
      'lensMount': instance.lensMount,
      'videoResolution': instance.videoResolution,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'hasWiFi': instance.hasWiFi,
      'hasBluetooth': instance.hasBluetooth,
      'batteryType': instance.batteryType,
      'batteryLife': instance.batteryLife,
    };
