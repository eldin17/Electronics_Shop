import 'package:flutter17_mobile/models/wishlist.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class WishlistProvider extends BaseCRUDProvider<Wishlist> {

  WishlistProvider() : super("api/Wishlist") ;

  @override
  Wishlist fromJson(data){
    return Wishlist.fromJson(data);
  }
}