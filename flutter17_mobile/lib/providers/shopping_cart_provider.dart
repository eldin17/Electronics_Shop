import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class ShoppingCartProvider extends BaseCRUDProvider<ShoppingCart> {

  ShoppingCartProvider() : super("api/ShoppingCart") ;

  @override
  ShoppingCart fromJson(data){
    return ShoppingCart.fromJson(data);
  }
}