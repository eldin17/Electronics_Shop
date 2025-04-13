import 'package:flutter17_mobile/models/cart_item.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class ShoppingCartItemProvider extends BaseCRUDProvider<CartItem> {

  ShoppingCartItemProvider() : super("api/CartItem") ;

  @override
  CartItem fromJson(data){
    return CartItem.fromJson(data);
  }
}