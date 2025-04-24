import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone {
  int? id;
  int? productId;

  // Display
  String? screenSize;
  String? screenResolution;
  String? screenType;
  int? refreshRate;

  // Performance
  String? processor;
  int? ram;
  int? storageCapacity;
  bool? supportsExpandableStorage;

  // Camera
  int? rearCamerasCount;
  bool? hasUltrawideLens;
  bool? hasZoomLens;
  int? mainCameraResolution;
  int? frontCameraResolution;

  // Battery
  int? batteryCapacity;
  bool? supportsFastCharging;
  bool? supportsWirelessCharging;
  int? estimatedBatteryLife;

  // Connectivity
  bool? supports5G;
  bool? hasWiFi6;
  bool? hasBluetooth;
  bool? hasNFC;
  bool? hasDualSIM;

  // Physical Characteristics
  double? weight;
  String? dimensions;
  String? buildMaterial;

  // Additional Features
  String? operatingSystem;
  bool? hasFingerprintSensor;
  bool? hasFaceRecognition;
  bool? isWaterResistant;

  Phone({
    this.id,
    this.productId,
    this.screenSize,
    this.screenResolution,
    this.screenType,
    this.refreshRate,
    this.processor,
    this.ram,
    this.storageCapacity,
    this.supportsExpandableStorage,
    this.rearCamerasCount,
    this.hasUltrawideLens,
    this.hasZoomLens,
    this.mainCameraResolution,
    this.frontCameraResolution,
    this.batteryCapacity,
    this.supportsFastCharging,
    this.supportsWirelessCharging,
    this.estimatedBatteryLife,
    this.supports5G,
    this.hasWiFi6,
    this.hasBluetooth,
    this.hasNFC,
    this.hasDualSIM,
    this.weight,
    this.dimensions,
    this.buildMaterial,
    this.operatingSystem,
    this.hasFingerprintSensor,
    this.hasFaceRecognition,
    this.isWaterResistant,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}
