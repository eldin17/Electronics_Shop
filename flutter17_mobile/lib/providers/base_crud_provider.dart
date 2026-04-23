import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/search_result.dart';
import 'package:flutter17_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

abstract class BaseCRUDProvider<T> extends BaseProvider<T> {
  String? baseUrl;
  String endpoint = "";

  BaseCRUDProvider(String endpointq) : super(endpointq) {
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
    endpoint = endpointq;
  }

  Future<T> add(dynamic obj) async {
    var url = "$baseUrl$endpoint";
    var uri = Uri.parse(url);

    var headers = await getHeaders(withAuth: true);

    var send = jsonEncode(obj);

    print("ADD ADD ADD $uri $send");
    try {
      var response = await sendWithRefresh(
          (headers) => http.post(uri, headers: headers, body: send));
      //var response = await http.post(uri, headers: headers, body: send);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }

  Future<T> update(int id, dynamic obj) async {
    var url = "$baseUrl$endpoint/$id";

    var headers = await getHeaders(withAuth: true);

    var uri = Uri.parse(url);
    var objEncoded = jsonEncode(obj);
    var body = objEncoded;
    try {
      var response = await sendWithRefresh(
          (headers) => http.put(uri, headers: headers, body: body));

      // var response = await http.put(
      //   uri,
      //   headers: headers,
      //   body: body,
      // );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        return fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }

  Future<T> delete(int id) async {
    var url = "$baseUrl$endpoint/$id";

    var headers = await getHeaders(withAuth: true);

    var uri = Uri.parse(url);
    print("DEL DEL DEL");
    print(url);

    try {
      var response = await sendWithRefresh(
          (headers) => http.delete(uri, headers: headers));
      // var response = await http.delete(
      //   uri,
      //   headers: headers,
      // );

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
}
