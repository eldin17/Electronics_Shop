import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:flutter17_mobile/models/wishlist_item.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class WishlistItemProvider extends BaseCRUDProvider<WishlistItem> {

  WishlistItemProvider() : super("api/WishlistItem") ;

  @override
  WishlistItem fromJson(data){
    return WishlistItem.fromJson(data);
  }
}