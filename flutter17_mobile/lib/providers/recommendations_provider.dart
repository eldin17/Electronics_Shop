import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../helpers/login_response.dart';
import '../models/adress.dart';
import '../models/search_result.dart';

class RecommendationsProvider with ChangeNotifier {
  String? baseUrl;
  RecommendationsProvider() {
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
  }

  Future<List<Product>> getRecommendations(int customerId, int productId, {int take = 3}) async {
    
    var url = "${baseUrl}api/Recommendation?customerId=$customerId&productId=$productId&take=$take";
    var headers = getHeaders(withAuth: true);
    var uri = Uri.parse(url);
    print(url);
        
    try {
      var response = await http.get(uri, headers: headers);

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

  Map<String, String> getHeaders({bool withAuth = true}) {
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

  @override
  Adress fromJson(data) {
    return Adress.fromJson(data);
  }
}
