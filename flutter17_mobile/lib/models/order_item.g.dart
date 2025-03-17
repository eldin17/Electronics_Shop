// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: (json['id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      orderId: (json['orderId'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      productColorId: (json['productColorId'] as num?)?.toInt(),
      productColor: json['productColor'] == null
          ? null
          : ProductColor.fromJson(json['productColor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'price': instance.price,
      'orderId': instance.orderId,
      'product': instance.product,
      'finalPrice': instance.finalPrice,
      'productColorId': instance.productColorId,
      'productColor': instance.productColor,
    };
