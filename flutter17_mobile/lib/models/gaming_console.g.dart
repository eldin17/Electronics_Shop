// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gaming_console.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamingConsole _$GamingConsoleFromJson(Map<String, dynamic> json) =>
    GamingConsole(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      processor: json['processor'] as String?,
      graphicsProcessor: json['graphicsProcessor'] as String?,
      ram: (json['ram'] as num?)?.toInt(),
      storageType: json['storageType'] as String?,
      storageCapacity: (json['storageCapacity'] as num?)?.toInt(),
      maxResolution: json['maxResolution'] as String?,
      maxFPS: (json['maxFPS'] as num?)?.toInt(),
      usbPorts: (json['usbPorts'] as num?)?.toInt(),
      hasWiFi: json['hasWiFi'] as bool?,
      hasBluetooth: json['hasBluetooth'] as bool?,
      hasEthernetPort: json['hasEthernetPort'] as bool?,
      supportsExternalStorage: json['supportsExternalStorage'] as bool?,
      supportsVR: json['supportsVR'] as bool?,
      hasPhysicalMediaDrive: json['hasPhysicalMediaDrive'] as bool?,
      isPortable: json['isPortable'] as bool?,
      controllerType: json['controllerType'] as String?,
      supportsBackwardCompatibility:
          json['supportsBackwardCompatibility'] as bool?,
      onlineService: json['onlineService'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
    );

Map<String, dynamic> _$GamingConsoleToJson(GamingConsole instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'processor': instance.processor,
      'graphicsProcessor': instance.graphicsProcessor,
      'ram': instance.ram,
      'storageType': instance.storageType,
      'storageCapacity': instance.storageCapacity,
      'maxResolution': instance.maxResolution,
      'maxFPS': instance.maxFPS,
      'usbPorts': instance.usbPorts,
      'hasWiFi': instance.hasWiFi,
      'hasBluetooth': instance.hasBluetooth,
      'hasEthernetPort': instance.hasEthernetPort,
      'supportsExternalStorage': instance.supportsExternalStorage,
      'supportsVR': instance.supportsVR,
      'hasPhysicalMediaDrive': instance.hasPhysicalMediaDrive,
      'isPortable': instance.isPortable,
      'controllerType': instance.controllerType,
      'supportsBackwardCompatibility': instance.supportsBackwardCompatibility,
      'onlineService': instance.onlineService,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
    };
