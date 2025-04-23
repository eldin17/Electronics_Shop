// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: (json['id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      shoppingCartId: (json['shoppingCartId'] as num?)?.toInt(),
      productColorId: (json['productColorId'] as num?)?.toInt(),
      productColor: json['productColor'] == null
          ? null
          : ProductColor.fromJson(json['productColor'] as Map<String, dynamic>),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'productId': instance.productId,
      'product': instance.product,
      'shoppingCartId': instance.shoppingCartId,
      'productColorId': instance.productColorId,
      'productColor': instance.productColor,
      'finalPrice': instance.finalPrice,
    };
