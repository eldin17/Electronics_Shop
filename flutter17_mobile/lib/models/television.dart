import 'package:json_annotation/json_annotation.dart';

part 'television.g.dart';

@JsonSerializable()
class Television {
  int? id;
  int? productId;

  // Display
  String? screenSize;
  String? screenResolution;
  String? screenType;
  bool? isSmartTV;
  int? refreshRate;
  bool? supportsHDR;

  // Audio
  int? speakerOutputPower;
  bool? supportsDolbyAtmos;

  // Connectivity
  int? hdmiInputs;
  int? usbPorts;
  bool? hasBluetooth;
  bool? hasWiFi;

  // Features
  String? operatingSystem;
  bool? supportsVoiceControl;
  bool? hasScreenMirroring;

  // Physical Characteristics
  double? weight;
  String? dimensions;
  String? standType;

  // Energy Efficiency
  String? energyRating;
  int? powerConsumption;

  Television({
    this.id,
    this.productId,
    this.screenSize,
    this.screenResolution,
    this.screenType,
    this.isSmartTV,
    this.refreshRate,
    this.supportsHDR,
    this.speakerOutputPower,
    this.supportsDolbyAtmos,
    this.hdmiInputs,
    this.usbPorts,
    this.hasBluetooth,
    this.hasWiFi,
    this.operatingSystem,
    this.supportsVoiceControl,
    this.hasScreenMirroring,
    this.weight,
    this.dimensions,
    this.standType,
    this.energyRating,
    this.powerConsumption,
  });

  factory Television.fromJson(Map<String, dynamic> json) => _$TelevisionFromJson(json);

  Map<String, dynamic> toJson() => _$TelevisionToJson(this);
}
