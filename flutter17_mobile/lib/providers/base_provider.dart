import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  String? baseUrl;
  String _endpoint = "";

  final storage = FlutterSecureStorage();
  BaseProvider(String endpoint) {
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
    _endpoint = endpoint;
  }

  Future<Response> sendWithRefresh(
      Future<Response> Function(Map<String, String> headers) requestFn) async {
    var headers = await getHeaders(withAuth: true);
    var response = await requestFn(headers);

    if (response.statusCode == 401) {
      await refreshToken();
      headers = await getHeaders(withAuth: true);
      response = await requestFn(headers);
    }

    return response;
  }

  Future<void> refreshToken() async {
    print("*********REFRESH TOKEN METHOD*********");
    final refreshToken = await storage.read(key: "refreshToken");
    final userId = await storage.read(key: "userId");
    if (refreshToken == null || userId == null) {
      throw Exception("No refresh token or user ID found");
    }
    var url = "${baseUrl}api/UserAccount/refresh";

    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "refreshToken": refreshToken,
        "userId": int.parse(userId), 
      }),
    );

    if (response.statusCode == 200) {
      print("Response: ${response.statusCode} ${response.body}");
      var data = jsonDecode(response.body);
      await storage.write(key: "accessToken", value: data['accessToken']);
      await storage.write(key: "refreshToken", value: data['refreshToken']);
    } else {
      throw Exception("Refresh failed, please login again");
    }
  }

  Future<SearchResult<T>> getAll({dynamic filter}) async {
    var url = "$baseUrl$_endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);

    try {
      var response =
          await sendWithRefresh((headers) => http.get(uri, headers: headers));
      //var response = await http.get(uri,headers: headers,);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        var result = SearchResult<T>();
        result.totalItems = data['totalItems'];

        for (var item in data['data']) {
          result.data.add(fromJson(item));
        }

        return result;
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }

  Future<T> getById(int id) async {
    var url = "$baseUrl$_endpoint/$id";

    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);

    try {
      var response = await sendWithRefresh((headers) => http.get(
            uri,
            headers: headers,
          ));
      // var response = await http.get(
      //   uri,
      //   headers: headers,
      // );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        var result = fromJson(data);
        print(result.toString());

        return result;
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
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

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['message'] ?? "An error occurred.");
    }
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }
}
