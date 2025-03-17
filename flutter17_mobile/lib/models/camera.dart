import 'package:flutter17_mobile/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'camera.g.dart';

@JsonSerializable()
class Camera {
  int? id;
  int? productId;

  // Technical Specifications
  double? megapixels;
  String? sensorType;
  String? lensMount;
  String? videoResolution;

  // Physical Characteristics
  double? weight;
  String? dimensions;

  // Connectivity
  bool? hasWiFi;
  bool? hasBluetooth;

  // Battery
  String? batteryType;
  int? batteryLife;

  Camera({
    this.id,
    this.productId,
    this.megapixels,
    this.sensorType,
    this.lensMount,
    this.videoResolution,
    this.weight,
    this.dimensions,
    this.hasWiFi,
    this.hasBluetooth,
    this.batteryType,
    this.batteryLife,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => _$CameraFromJson(json);

  Map<String, dynamic> toJson() => _$CameraToJson(this);
}
