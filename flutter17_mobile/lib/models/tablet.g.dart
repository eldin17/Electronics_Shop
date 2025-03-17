// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tablet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tablet _$TabletFromJson(Map<String, dynamic> json) => Tablet(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      screenSize: json['screenSize'] as String?,
      screenResolution: json['screenResolution'] as String?,
      screenType: json['screenType'] as String?,
      refreshRate: (json['refreshRate'] as num?)?.toInt(),
      processor: json['processor'] as String?,
      ram: (json['ram'] as num?)?.toInt(),
      storageCapacity: (json['storageCapacity'] as num?)?.toInt(),
      supportsExpandableStorage: json['supportsExpandableStorage'] as bool?,
      rearCameraResolution: json['rearCameraResolution'] as String?,
      frontCameraResolution: json['frontCameraResolution'] as String?,
      batteryCapacity: (json['batteryCapacity'] as num?)?.toInt(),
      estimatedBatteryLife: (json['estimatedBatteryLife'] as num?)?.toInt(),
      supportsFastCharging: json['supportsFastCharging'] as bool?,
      supportsWirelessCharging: json['supportsWirelessCharging'] as bool?,
      supports5G: json['supports5G'] as bool?,
      hasWiFi6: json['hasWiFi6'] as bool?,
      hasBluetooth: json['hasBluetooth'] as bool?,
      hasCellular: json['hasCellular'] as bool?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      buildMaterial: json['buildMaterial'] as String?,
      operatingSystem: json['operatingSystem'] as String?,
      supportsStylus: json['supportsStylus'] as bool?,
      hasFingerprintSensor: json['hasFingerprintSensor'] as bool?,
      hasFaceRecognition: json['hasFaceRecognition'] as bool?,
      isWaterResistant: json['isWaterResistant'] as bool?,
    );

Map<String, dynamic> _$TabletToJson(Tablet instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'screenSize': instance.screenSize,
      'screenResolution': instance.screenResolution,
      'screenType': instance.screenType,
      'refreshRate': instance.refreshRate,
      'processor': instance.processor,
      'ram': instance.ram,
      'storageCapacity': instance.storageCapacity,
      'supportsExpandableStorage': instance.supportsExpandableStorage,
      'rearCameraResolution': instance.rearCameraResolution,
      'frontCameraResolution': instance.frontCameraResolution,
      'batteryCapacity': instance.batteryCapacity,
      'estimatedBatteryLife': instance.estimatedBatteryLife,
      'supportsFastCharging': instance.supportsFastCharging,
      'supportsWirelessCharging': instance.supportsWirelessCharging,
      'supports5G': instance.supports5G,
      'hasWiFi6': instance.hasWiFi6,
      'hasBluetooth': instance.hasBluetooth,
      'hasCellular': instance.hasCellular,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'buildMaterial': instance.buildMaterial,
      'operatingSystem': instance.operatingSystem,
      'supportsStylus': instance.supportsStylus,
      'hasFingerprintSensor': instance.hasFingerprintSensor,
      'hasFaceRecognition': instance.hasFaceRecognition,
      'isWaterResistant': instance.isWaterResistant,
    };
