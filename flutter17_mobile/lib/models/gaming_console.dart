import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'gaming_console.g.dart';

@JsonSerializable()
class GamingConsole {
  int? id;
  int? productId;

  // General Information        
  String? processor;
  String? graphicsProcessor;

  // Performance
  int? ram; // RAM size in GB
  String? storageType;
  int? storageCapacity; // Storage size in GB or TB
  String? maxResolution;
  int? maxFPS; // Maximum Frames Per Second

  // Connectivity
  int? usbPorts;
  bool? hasWiFi;
  bool? hasBluetooth;
  bool? hasEthernetPort;
  bool? supportsExternalStorage;

  // Features
  bool? supportsVR;
  bool? hasPhysicalMediaDrive;
  bool? isPortable;

  // Additional Features
  String? controllerType;
  bool? supportsBackwardCompatibility;
  String? onlineService;

  // Dimensions and Weight
  double? weight;
  String? dimensions;
  
  GamingConsole({
    this.id,
    this.productId,
    this.processor,
    this.graphicsProcessor,
    this.ram,
    this.storageType,
    this.storageCapacity,
    this.maxResolution,
    this.maxFPS,
    this.usbPorts,
    this.hasWiFi,
    this.hasBluetooth,
    this.hasEthernetPort,
    this.supportsExternalStorage,
    this.supportsVR,
    this.hasPhysicalMediaDrive,
    this.isPortable,
    this.controllerType,
    this.supportsBackwardCompatibility,
    this.onlineService,
    this.weight,
    this.dimensions,
  });

  factory GamingConsole.fromJson(Map<String, dynamic> json) =>
      _$GamingConsoleFromJson(json);

  Map<String, dynamic> toJson() => _$GamingConsoleToJson(this);
}
