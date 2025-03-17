import 'package:flutter17_mobile/models/accessory.dart';
import 'package:flutter17_mobile/models/adress.dart';
import 'package:flutter17_mobile/models/camera.dart';
import 'package:flutter17_mobile/models/desktopPC.dart';
import 'package:flutter17_mobile/models/gaming_console.dart';
import 'package:flutter17_mobile/models/laptop.dart';
import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/models/phone.dart';
import 'package:flutter17_mobile/models/product_category.dart';
import 'package:flutter17_mobile/models/product_color.dart';
import 'package:flutter17_mobile/models/product_image.dart';
import 'package:flutter17_mobile/models/product_product_tag.dart';
import 'package:flutter17_mobile/models/review.dart';
import 'package:flutter17_mobile/models/tablet.dart';
import 'package:flutter17_mobile/models/television.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/models/warranty.dart';
import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? brand;
  String? model;
  String? description;
  double? price;
  double? finalPrice;
  int? productCategoryId;
  ProductCategory? productCategory;
  List<ProductImage>? productImage;
  List<ProductColor>? productColor;
  List<ProductProductTag>? productProductTag;
  List<Review>? review;
  int? warrantyId;
  Warranty? warranty;
  Camera? camera;
  DesktopPC? desktopPC;
  GamingConsole? gamingConsole;
  Laptop? laptop;
  Phone? phone;
  Tablet? tablet;
  Television? television;
  Accessory? accessory;
  bool? isDeleted;

  Product({    
    this.id,
    this.brand,
    this.model,
    this.description,
    this.price,
    this.finalPrice,
    this.productCategoryId,
    this.productCategory,
    this.productImage,
    this.productColor,
    this.productProductTag,
    this.review,
    this.warrantyId,
    this.warranty,
    this.camera,
    this.desktopPC,
    this.gamingConsole,
    this.laptop,
    this.phone,
    this.tablet,
    this.television,
    this.accessory,
    this.isDeleted,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}