import 'package:flutter17_mobile/models/wishlist_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class Wishlist {
  int? id;
  String? customerId;
  DateTime? dateCreated;
  List<WishlistItem>? wishlistItems;

  Wishlist({
    this.id,
    this.customerId,
    this.dateCreated,
    this.wishlistItems,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}