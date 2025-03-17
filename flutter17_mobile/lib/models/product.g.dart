// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      productCategoryId: (json['productCategoryId'] as num?)?.toInt(),
      productCategory: json['productCategory'] == null
          ? null
          : ProductCategory.fromJson(
              json['productCategory'] as Map<String, dynamic>),
      productImage: (json['productImage'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      productColor: (json['productColor'] as List<dynamic>?)
          ?.map((e) => ProductColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      productProductTag: (json['productProductTag'] as List<dynamic>?)
          ?.map((e) => ProductProductTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      review: (json['review'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      warrantyId: (json['warrantyId'] as num?)?.toInt(),
      warranty: json['warranty'] == null
          ? null
          : Warranty.fromJson(json['warranty'] as Map<String, dynamic>),
      camera: json['camera'] == null
          ? null
          : Camera.fromJson(json['camera'] as Map<String, dynamic>),
      desktopPC: json['desktopPC'] == null
          ? null
          : DesktopPC.fromJson(json['desktopPC'] as Map<String, dynamic>),
      gamingConsole: json['gamingConsole'] == null
          ? null
          : GamingConsole.fromJson(
              json['gamingConsole'] as Map<String, dynamic>),
      laptop: json['laptop'] == null
          ? null
          : Laptop.fromJson(json['laptop'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      tablet: json['tablet'] == null
          ? null
          : Tablet.fromJson(json['tablet'] as Map<String, dynamic>),
      television: json['television'] == null
          ? null
          : Television.fromJson(json['television'] as Map<String, dynamic>),
      accessory: json['accessory'] == null
          ? null
          : Accessory.fromJson(json['accessory'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'description': instance.description,
      'price': instance.price,
      'finalPrice': instance.finalPrice,
      'productCategoryId': instance.productCategoryId,
      'productCategory': instance.productCategory,
      'productImage': instance.productImage,
      'productColor': instance.productColor,
      'productProductTag': instance.productProductTag,
      'review': instance.review,
      'warrantyId': instance.warrantyId,
      'warranty': instance.warranty,
      'camera': instance.camera,
      'desktopPC': instance.desktopPC,
      'gamingConsole': instance.gamingConsole,
      'laptop': instance.laptop,
      'phone': instance.phone,
      'tablet': instance.tablet,
      'television': instance.television,
      'accessory': instance.accessory,
      'isDeleted': instance.isDeleted,
    };
