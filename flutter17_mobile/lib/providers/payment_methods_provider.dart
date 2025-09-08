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

  Future<PaymentMethod> findAndDelete(PayMethDel obj) async {
    var url = "$baseUrl$endpoint/FindAndDelete";

    var headers = getHeaders(withAuth: true);
    var delObj = jsonEncode(obj);

    var uri = Uri.parse(url);
    print("findAndDelete DEL DEL DEL");

    try {
      var response = await http.delete(
        uri,
        headers: headers,
        body:delObj
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        var result = fromJson(data);

        return result;
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }
}
