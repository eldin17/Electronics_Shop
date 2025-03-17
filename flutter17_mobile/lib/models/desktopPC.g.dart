// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desktopPC.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesktopPC _$DesktopPCFromJson(Map<String, dynamic> json) => DesktopPC(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      processor: json['processor'] as String?,
      ram: (json['ram'] as num?)?.toInt(),
      storageType: json['storageType'] as String?,
      storageCapacity: (json['storageCapacity'] as num?)?.toInt(),
      graphicsCard: json['graphicsCard'] as String?,
      operatingSystem: json['operatingSystem'] as String?,
      formFactor: json['formFactor'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      usbPorts: (json['usbPorts'] as num?)?.toInt(),
      hasWiFi: json['hasWiFi'] as bool?,
      hasBluetooth: json['hasBluetooth'] as bool?,
      powerSupplyWattage: (json['powerSupplyWattage'] as num?)?.toInt(),
      coolingType: json['coolingType'] as String?,
      hasRGBLighting: json['hasRGBLighting'] as bool?,
    );

Map<String, dynamic> _$DesktopPCToJson(DesktopPC instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'processor': instance.processor,
      'ram': instance.ram,
      'storageType': instance.storageType,
      'storageCapacity': instance.storageCapacity,
      'graphicsCard': instance.graphicsCard,
      'operatingSystem': instance.operatingSystem,
      'formFactor': instance.formFactor,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'usbPorts': instance.usbPorts,
      'hasWiFi': instance.hasWiFi,
      'hasBluetooth': instance.hasBluetooth,
      'powerSupplyWattage': instance.powerSupplyWattage,
      'coolingType': instance.coolingType,
      'hasRGBLighting': instance.hasRGBLighting,
    };
