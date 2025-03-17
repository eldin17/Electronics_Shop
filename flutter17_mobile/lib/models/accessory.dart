import 'package:flutter17_mobile/models/accessory_category.dart';
import 'package:flutter17_mobile/models/accessory_property.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accessory.g.dart';

@JsonSerializable(explicitToJson: true)
class Accessory {
  int? id;
  String? name;
  String? description;
  int? productId;
  AccessoryCategory? accessoryCategory;
  List<AccessoryProperty>? accessoryProperties;

  Accessory({
    this.id,
    this.name,
    this.description,
    this.productId,
    this.accessoryCategory,
    this.accessoryProperties,
  });

  factory Accessory.fromJson(Map<String, dynamic> json) => _$AccessoryFromJson(json);

  Map<String, dynamic> toJson() => _$AccessoryToJson(this);
}
