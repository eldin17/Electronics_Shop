import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/product_color.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  int? id;
  int? quantity;
  double? price;
  int? orderId;
  Product? product;
  double? finalPrice;
  int? productColorId;
  ProductColor? productColor;

  OrderItem({
    this.id,
    this.quantity,
    this.price,
    this.orderId,
    this.product,
    this.finalPrice,
    this.productColorId,
    this.productColor,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}