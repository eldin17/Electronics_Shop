// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'television.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Television _$TelevisionFromJson(Map<String, dynamic> json) => Television(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      screenSize: json['screenSize'] as String?,
      screenResolution: json['screenResolution'] as String?,
      screenType: json['screenType'] as String?,
      isSmartTV: json['isSmartTV'] as bool?,
      refreshRate: (json['refreshRate'] as num?)?.toInt(),
      supportsHDR: json['supportsHDR'] as bool?,
      speakerOutputPower: (json['speakerOutputPower'] as num?)?.toInt(),
      supportsDolbyAtmos: json['supportsDolbyAtmos'] as bool?,
      hdmiInputs: (json['hdmiInputs'] as num?)?.toInt(),
      usbPorts: (json['usbPorts'] as num?)?.toInt(),
      hasBluetooth: json['hasBluetooth'] as bool?,
      hasWiFi: json['hasWiFi'] as bool?,
      operatingSystem: json['operatingSystem'] as String?,
      supportsVoiceControl: json['supportsVoiceControl'] as bool?,
      hasScreenMirroring: json['hasScreenMirroring'] as bool?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      standType: json['standType'] as String?,
      energyRating: json['energyRating'] as String?,
      powerConsumption: (json['powerConsumption'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TelevisionToJson(Television instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'screenSize': instance.screenSize,
      'screenResolution': instance.screenResolution,
      'screenType': instance.screenType,
      'isSmartTV': instance.isSmartTV,
      'refreshRate': instance.refreshRate,
      'supportsHDR': instance.supportsHDR,
      'speakerOutputPower': instance.speakerOutputPower,
      'supportsDolbyAtmos': instance.supportsDolbyAtmos,
      'hdmiInputs': instance.hdmiInputs,
      'usbPorts': instance.usbPorts,
      'hasBluetooth': instance.hasBluetooth,
      'hasWiFi': instance.hasWiFi,
      'operatingSystem': instance.operatingSystem,
      'supportsVoiceControl': instance.supportsVoiceControl,
      'hasScreenMirroring': instance.hasScreenMirroring,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'standType': instance.standType,
      'energyRating': instance.energyRating,
      'powerConsumption': instance.powerConsumption,
    };
