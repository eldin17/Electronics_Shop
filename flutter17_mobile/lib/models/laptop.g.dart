// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laptop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Laptop _$LaptopFromJson(Map<String, dynamic> json) => Laptop(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      processor: json['processor'] as String?,
      ram: (json['ram'] as num?)?.toInt(),
      storageType: json['storageType'] as String?,
      storageCapacity: (json['storageCapacity'] as num?)?.toInt(),
      graphicsCard: json['graphicsCard'] as String?,
      screenSize: json['screenSize'] as String?,
      screenResolution: json['screenResolution'] as String?,
      screenType: json['screenType'] as String?,
      batteryCapacity: (json['batteryCapacity'] as num?)?.toInt(),
      batteryLife: (json['batteryLife'] as num?)?.toInt(),
      hasWiFi: json['hasWiFi'] as bool?,
      hasBluetooth: json['hasBluetooth'] as bool?,
      usbPorts: (json['usbPorts'] as num?)?.toInt(),
      hasEthernetPort: json['hasEthernetPort'] as bool?,
      hasHDMI: json['hasHDMI'] as bool?,
      hasThunderbolt: json['hasThunderbolt'] as bool?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      buildMaterial: json['buildMaterial'] as String?,
      hasBacklitKeyboard: json['hasBacklitKeyboard'] as bool?,
      hasFingerprintReader: json['hasFingerprintReader'] as bool?,
      hasWebcam: json['hasWebcam'] as bool?,
      operatingSystem: json['operatingSystem'] as String?,
    );

Map<String, dynamic> _$LaptopToJson(Laptop instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'processor': instance.processor,
      'ram': instance.ram,
      'storageType': instance.storageType,
      'storageCapacity': instance.storageCapacity,
      'graphicsCard': instance.graphicsCard,
      'screenSize': instance.screenSize,
      'screenResolution': instance.screenResolution,
      'screenType': instance.screenType,
      'batteryCapacity': instance.batteryCapacity,
      'batteryLife': instance.batteryLife,
      'hasWiFi': instance.hasWiFi,
      'hasBluetooth': instance.hasBluetooth,
      'usbPorts': instance.usbPorts,
      'hasEthernetPort': instance.hasEthernetPort,
      'hasHDMI': instance.hasHDMI,
      'hasThunderbolt': instance.hasThunderbolt,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'buildMaterial': instance.buildMaterial,
      'hasBacklitKeyboard': instance.hasBacklitKeyboard,
      'hasFingerprintReader': instance.hasFingerprintReader,
      'hasWebcam': instance.hasWebcam,
      'operatingSystem': instance.operatingSystem,
    };
