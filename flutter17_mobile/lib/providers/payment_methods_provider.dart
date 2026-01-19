import 'dart:convert';

import 'package:flutter17_mobile/models/payment_method.dart';
import 'package:flutter17_mobile/models/payment_method_del.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;

class PaymentMethodProvider extends BaseCRUDProvider<PaymentMethod> {
  PaymentMethodProvider() : super("api/PaymentMethod");

  @override
  PaymentMethod fromJson(data) {
    return PaymentMethod.fromJson(data);
  }

  
}
