import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CustomerProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "api/Customer";

  CustomerProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
  }

  Future<void> registerCustomer(String obj) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    
    var headers = _getHeaders(withAuth: true);

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: obj,
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return;
      }
    } catch (e) {
      throw Exception("Customer Registration failed: ${e.toString()}");
    }
  }

  Map<String, String> _getHeaders({bool withAuth = true}) {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (withAuth) {
      headers["Authorization"] = "Bearer ${LoginResponse.token}";
    }

    return headers;
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['message'] ?? "An error occurred.");
    }
  }
}
