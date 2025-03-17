import 'package:json_annotation/json_annotation.dart';

part 'laptop.g.dart';

@JsonSerializable()
class Laptop {
  int? id;
  int? productId;

  // Performance
  String? processor;
  int? ram;
  String? storageType;
  int? storageCapacity;
  String? graphicsCard;

  // Display
  String? screenSize;
  String? screenResolution;
  String? screenType;

  // Battery
  int? batteryCapacity;
  int? batteryLife;

  // Connectivity
  bool? hasWiFi;
  bool? hasBluetooth;
  int? usbPorts;
  bool? hasEthernetPort;
  bool? hasHDMI;
  bool? hasThunderbolt;

  // Physical Characteristics
  double? weight;
  String? dimensions;
  String? buildMaterial;

  // Additional Features
  bool? hasBacklitKeyboard;
  bool? hasFingerprintReader;
  bool? hasWebcam;
  String? operatingSystem;

  Laptop({
    this.id,
    this.productId,
    this.processor,
    this.ram,
    this.storageType,
    this.storageCapacity,
    this.graphicsCard,
    this.screenSize,
    this.screenResolution,
    this.screenType,
    this.batteryCapacity,
    this.batteryLife,
    this.hasWiFi,
    this.hasBluetooth,
    this.usbPorts,
    this.hasEthernetPort,
    this.hasHDMI,
    this.hasThunderbolt,
    this.weight,
    this.dimensions,
    this.buildMaterial,
    this.hasBacklitKeyboard,
    this.hasFingerprintReader,
    this.hasWebcam,
    this.operatingSystem,
  });

  factory Laptop.fromJson(Map<String, dynamic> json) => _$LaptopFromJson(json);

  Map<String, dynamic> toJson() => _$LaptopToJson(this);
}
