import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/login_model.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../models/register_model.dart';

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "api/UserAccount";

  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
  }

  // Future<void> login(LoginModel obj) async {
  //   var url = "$_baseUrl$_endpoint/login";
  //   var uri = Uri.parse(url);

  //   var body = {
  //     "username": obj.username,
  //     "password": obj.password,
  //   };

  //   var headers = _getHeaders(withAuth: false);

  //   try {
  //     print("Sending login request...");
  //     var client = http.Client();
  //     try {
  //       var response =
  //           await client.post(uri, headers: headers, body: jsonEncode(body));
  //       // Handle response

  //       print("Received response with status code: ${response.statusCode}");
  //       if (response.statusCode == 200) {
  //         var data = jsonDecode(response.body);
  //         print("Login successful. Token: ${data['token']}");
  //       } else {
  //         print("Login failed with status: ${response.statusCode}");
  //       }
  //     } finally {
  //       client.close();
  //     }
  //   } catch (e) {
  //     print("Error during HTTP call: $e");
  //   }
  // }
  Future<void> login(LoginModel obj) async {
    var url = "$_baseUrl$_endpoint/login";
    var uri = Uri.parse(url);

    var body = {
      "username": obj.username,
      "password": obj.password,
    };

    var headers = _getHeaders(withAuth: false);

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        LoginResponse.token = data['token'];
        LoginResponse.userId = data['userId'];
        LoginResponse.roleName = data['roleName'];
        LoginResponse.isCustomer = data['isCustomer'];
        LoginResponse.isSeller = data['isSeller'];

        return;
      }
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  Future<UserAccount> register(RegisterModel obj) async {
    var url = "$_baseUrl$_endpoint/register";
    var uri = Uri.parse(url);

    var body = {
      "username": obj.username,
      "email": obj.email,
      "password": obj.password,
      "roleId": obj.roleId,
      "imageId": obj.imageId,
    };

    var headers = _getHeaders(withAuth: false);

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return UserAccount.fromJson(data);
      }
    } catch (e) {
      throw Exception("Registration failed: ${e.toString()}");
    }
    return UserAccount();
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
