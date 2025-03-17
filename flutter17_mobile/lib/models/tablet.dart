import 'package:json_annotation/json_annotation.dart';

part 'tablet.g.dart';

@JsonSerializable()
class Tablet {
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
  String? rearCameraResolution;
  String? frontCameraResolution;

  // Battery
  int? batteryCapacity;
  int? estimatedBatteryLife;
  bool? supportsFastCharging;
  bool? supportsWirelessCharging;

  // Connectivity
  bool? supports5G;
  bool? hasWiFi6;
  bool? hasBluetooth;
  bool? hasCellular;

  // Physical Characteristics
  double? weight;
  String? dimensions;
  String? buildMaterial;

  // Additional Features
  String? operatingSystem;
  bool? supportsStylus;
  bool? hasFingerprintSensor;
  bool? hasFaceRecognition;
  bool? isWaterResistant;

  Tablet({
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
    this.rearCameraResolution,
    this.frontCameraResolution,
    this.batteryCapacity,
    this.estimatedBatteryLife,
    this.supportsFastCharging,
    this.supportsWirelessCharging,
    this.supports5G,
    this.hasWiFi6,
    this.hasBluetooth,
    this.hasCellular,
    this.weight,
    this.dimensions,
    this.buildMaterial,
    this.operatingSystem,
    this.supportsStylus,
    this.hasFingerprintSensor,
    this.hasFaceRecognition,
    this.isWaterResistant,
  });

  factory Tablet.fromJson(Map<String, dynamic> json) => _$TabletFromJson(json);

  Map<String, dynamic> toJson() => _$TabletToJson(this);
}
