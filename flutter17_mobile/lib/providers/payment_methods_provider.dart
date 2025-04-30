import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class PaymentMethodProvider extends BaseCRUDProvider<PaymentMethod> {
  PaymentMethodProvider() : super("api/PaymentMethod");

  @override
  PaymentMethod fromJson(data) {
    return PaymentMethod.fromJson(data);
  }
}
