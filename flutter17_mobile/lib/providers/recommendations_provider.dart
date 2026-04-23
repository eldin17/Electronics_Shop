import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../helpers/login_response.dart';
import '../models/adress.dart';
import '../models/search_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RecommendationsProvider with ChangeNotifier {
  String? baseUrl;
  final storage = FlutterSecureStorage();

  RecommendationsProvider() {
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
  }

  Future<List<Product>> getRecommendations(int customerId, int productId,
      {int take = 3}) async {
    var url =
        "${baseUrl}api/Recommendation?customerId=$customerId&productId=$productId&take=$take";
    var headers = await getHeaders(withAuth: true);
    var uri = Uri.parse(url);
    print(url);

    try {
      var response =
          await sendWithRefresh((headers) => http.get(uri, headers: headers));
      //var response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        List<dynamic> data = jsonDecode(response.body);

        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        print("Server error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Network/Parsing error: $e");
      return [];
    }

    return [];
  }

  Future<Map<String, String>> getHeaders({bool withAuth = true}) async {
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

  @override
  Adress fromJson(data) {
    return Adress.fromJson(data);
  }

  Future<Response> sendWithRefresh(
      Future<Response> Function(Map<String, String> headers) requestFn) async {
    var headers = await getHeaders(withAuth: true);
    var response = await requestFn(headers);

    if (response.statusCode == 401) {
      // Access token expired → refresh
      await refreshToken();
      headers = await getHeaders(withAuth: true);
      response = await requestFn(headers);
    }

    return response;
  }

  Future<void> refreshToken() async {
    final refreshToken = await storage.read(key: "refreshToken");
    if (refreshToken == null) throw Exception("No refresh token found");

    var url = "${baseUrl}api/UserAccount/refresh";
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
