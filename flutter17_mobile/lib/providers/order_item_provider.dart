import 'package:flutter17_mobile/models/order_item.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class OrderItemProvider extends BaseCRUDProvider<OrderItem> {

  OrderItemProvider() : super("api/OrderItem") ;

  @override
  OrderItem fromJson(data){
    return OrderItem.fromJson(data);
  }
}
