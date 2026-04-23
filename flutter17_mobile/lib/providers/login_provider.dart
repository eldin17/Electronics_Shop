import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/login_model.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/providers/customer_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/register_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "api/UserAccount";
  late CustomerProvider _customerProvider;
  final storage = FlutterSecureStorage();

  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
    _customerProvider = new CustomerProvider();
  }

  Future<void> login(LoginModel obj) async {
    var url = "$_baseUrl$_endpoint/login";
    var uri = Uri.parse(url);

    var body = {
      "username": obj.username,
      "password": obj.password,
    };

    var headers = await _getHeaders(withAuth: false);

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        await storage.write(key: "accessToken", value: data['accessToken']);
        await storage.write(key: "refreshToken", value: data['refreshToken']);
        await storage.write(key: "userId", value: data['userId']);

        LoginResponse.accessToken = await storage.read(key: "accessToken");
        LoginResponse.userId = data['userId'];
        LoginResponse.roleName = data['roleName'];
        LoginResponse.isCustomer = data['isCustomer'];
        LoginResponse.isSeller = data['isSeller'];

        if (LoginResponse.isCustomer!) {
          var customer = await _customerProvider
              .getAll(filter: {'userAccountId': LoginResponse.userId});
          if (customer.data.isNotEmpty)
            LoginResponse.currentCustomer = customer.data[0];
          print("HepeK!! ${LoginResponse.currentCustomer!.id}");
        }

        return;
      }
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  Future<void> logout(int userId) async {
    var url = "$_baseUrl$_endpoint/logout/$userId";
    print(url);
    var headers = await _getHeaders(withAuth: true);
    var response = await sendWithRefresh(
        (headers) => http.post(Uri.parse(url), headers: headers));
    //var response = await http.post(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      await storage.delete(key: "accessToken");
      await storage.delete(key: "refreshToken");
      print("LOGOUT ${userId}");
      var box = Hive.box('authBox');
      await box.delete('accessToken');
      await box.delete('userId');
      await box.delete('roleName');
      await box.delete('isCustomer');
      await box.delete('isSeller');

      LoginResponse.accessToken = null;
      LoginResponse.refreshToken = null;
      LoginResponse.userId = null;
      LoginResponse.roleName = null;
      LoginResponse.isCustomer = null;
      LoginResponse.isSeller = null;
      LoginResponse.currentCustomer = null;
    } else {
      throw Exception("Logout failed");
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

    var headers = await _getHeaders(withAuth: false);

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

  Future<Map<String, String>> _getHeaders({bool withAuth = true}) async {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final accessToken = await storage.read(key: "accessToken");
    if (withAuth) {
      headers["Authorization"] = "Bearer ${accessToken}";
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

  Future<Response> sendWithRefresh(
      Future<Response> Function(Map<String, String> headers) requestFn) async {
    var headers = await _getHeaders(withAuth: true);
    var response = await requestFn(headers);

    if (response.statusCode == 401) {
      await refreshToken();
      headers = await _getHeaders(withAuth: false);
      response = await requestFn(headers);
    }

    return response;
  }

  Future<void> refreshToken() async {
    final refreshToken = await storage.read(key: "refreshToken");
    if (refreshToken == null) throw Exception("No refresh token found");

    var url = "${_baseUrl}api/UserAccount/refresh";
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await storage.write(key: "accessToken", value: data['accessToken']);
      await storage.write(key: "refreshToken", value: data['refreshToken']);
    } else {
      throw Exception("Refresh failed, please login again");
    }
  }
}
