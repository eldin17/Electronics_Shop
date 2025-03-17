import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/coupon.dart';
import 'package:flutter17_mobile/models/customer.dart';
import 'package:flutter17_mobile/models/order_item.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  DateTime? orderTime;
  double? totalAmount;
  double? finalTotalAmount;
  Customer? customer;
  Adress? adress;
  Coupon? coupon;
  PaymentMethod? paymentMethod;
  List<OrderItem>? orderItems;

  Order({
    this.id,
    this.orderTime,
    this.totalAmount,
    this.finalTotalAmount,
    this.customer,
    this.adress,
    this.coupon,
    this.paymentMethod,
    this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}