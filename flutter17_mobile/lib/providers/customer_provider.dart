import 'package:flutter17_mobile/models/customer.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class CustomerProvider extends BaseCRUDProvider<Customer> {

  CustomerProvider() : super("api/Customer") ;

  @override
  Customer fromJson(data){
    return Customer.fromJson(data);
  }
}
