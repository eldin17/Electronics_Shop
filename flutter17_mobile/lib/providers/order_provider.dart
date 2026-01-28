import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/order.dart';
import '../models/order_suggestion.dart';



class OrderProvider extends BaseCRUDProvider<Order> {
  OrderProvider() : super("api/Order");

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  } 

  Future<Order> addFromCart(dynamic obj) async {
    var url = "${baseUrl}api/Order/AddByCart";
    var uri = Uri.parse(url);

    var headers = getHeaders(withAuth: true);

    var send = jsonEncode(obj);

    print("ADD ADD ADD $uri $send");
    try {
      var response = await http.post(uri, headers: headers, body: send);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }



  Future<OrderSuggestion> checkAndActivate(dynamic obj) async {
    var url = "${baseUrl}api/Order/CheckAndActivate";
    var uri = Uri.parse(url);

    var headers = getHeaders(withAuth: true);

    var send = jsonEncode(obj);

    print("ADD ADD ADD $uri $send");
    try {
      var response = await http.post(uri, headers: headers, body: send);

      if (isValidResponse(response)) {
        print("Response length: ${response.body.length}");
        print("Response body start: ${response.body.substring(0, 200)}");
        var data = jsonDecode(response.body);
        return OrderSuggestion.fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }

  Future<OrderSuggestion> confirmOrder(
    int orderId,
    int cartId, {
    int? paymentId,
    String? paymentIntent,
  }) async {
    var url = "${baseUrl}api/Order/Confirm/$orderId";
    var uri = Uri.parse(
      "${baseUrl}api/Order/Confirm/$orderId",
    ).replace(
      queryParameters: {
        "cartId": cartId.toString(),
      },
    );

    var headers = getHeaders(withAuth: true);

    print("CONFIRM ORDER $uri");

    try {
      var response = await http.patch(
        uri,
        headers: headers,
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return OrderSuggestion.fromJson(data);
      }
    } catch (e) {
      throw Exception("Confirm failed: ${e.toString()}");
    }
    throw Exception("Unexpected error during confirm");
  }

  Future<OrderSuggestion> confirmStripeOrder(
    int orderId,
    int cartId,
  ) async {
    final uri = Uri.parse(
      "${baseUrl}api/Order/ConfirmStripe/$orderId",
    ).replace(
      queryParameters: {
        "cartId": cartId.toString(),
      },
    );

    final headers = getHeaders(withAuth: true);

    print("CONFIRM STRIPE ORDER $uri");

    try {
      final response = await http.patch(
        uri,
        headers: headers,
      );

      if (isValidResponse(response)) {
        final data = jsonDecode(response.body);
        return OrderSuggestion.fromJson(data);
      }
    } catch (e) {
      throw Exception("ConfirmStripe failed: ${e.toString()}");
    }

    throw Exception("Unexpected error during ConfirmStripe");
  }

  Future<Order> deleteOrderAndCoupon(int id) async {
    var url = "${baseUrl}api/Order/DeleteOrderAndCoupon/$id";

    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);
    print("DEL DEL DEL $uri");

    try {
      var response = await http.delete(
        uri,
        headers: headers,
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

  Future<Order> backToDraft(int id) async {
  final url = "${baseUrl}api/Order/BackToDraft/$id";
  final uri = Uri.parse(url);

  final headers = getHeaders(withAuth: true);

  try {
    final response = await http.patch(uri, headers: headers);

    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);
      return Order.fromJson(data);
    }
  } catch (e) {
    throw Exception("BackToDraft failed: ${e.toString()}");
  }

  throw Exception("BackToDraft request failed");
}

}
