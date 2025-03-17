import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'desktopPC.g.dart';

@JsonSerializable()
class DesktopPC {
  int? id;
  int? productId;

  // General Information
  String? processor;
  int? ram; // RAM size in GB
  String? storageType;
  int? storageCapacity; // Storage size in GB or TB
  String? graphicsCard;
  String? operatingSystem;

  // Physical Characteristics
  String? formFactor;
  double? weight;
  String? dimensions;

  // Connectivity
  int? usbPorts; // Number of USB ports
  bool? hasWiFi;
  bool? hasBluetooth;

  // Power Supply
  int? powerSupplyWattage; // PSU wattage

  // Cooling
  String? coolingType;

  // Additional Features
  bool? hasRGBLighting;

  DesktopPC({
    this.id,
    this.productId,
    this.processor,
    this.ram,
    this.storageType,
    this.storageCapacity,
    this.graphicsCard,
    this.operatingSystem,
    this.formFactor,
    this.weight,
    this.dimensions,
    this.usbPorts,
    this.hasWiFi,
    this.hasBluetooth,
    this.powerSupplyWattage,
    this.coolingType,
    this.hasRGBLighting,
  });

  factory DesktopPC.fromJson(Map<String, dynamic> json) =>
      _$DesktopPCFromJson(json);

  Map<String, dynamic> toJson() => _$DesktopPCToJson(this);
}
