import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_cart.g.dart';

@JsonSerializable()
class ShoppingCart {
  int? id;
  int? customerId;
  DateTime? dateCreated;
  List<CartItem>? cartItems;
  double? totalAmount;

  ShoppingCart({
    this.id,
    this.customerId, 
    this.dateCreated,
    this.cartItems,
    this.totalAmount,
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => _$ShoppingCartFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartToJson(this);
}