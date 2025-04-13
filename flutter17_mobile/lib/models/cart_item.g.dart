// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: (json['id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      shoppingCartId: (json['shoppingCartId'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'productId': instance.productId,
      'shoppingCartId': instance.shoppingCartId,
      'finalPrice': instance.finalPrice,
      'product': instance.product,
    };
