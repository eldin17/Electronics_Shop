
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/models/image.dart' as Model;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart';
bool isTokenExpired(String? token) {
  if (token == null) return true; 
  try {
    final jwt = JWT.decode(token);
    final exp = jwt.payload['exp']; 

    if (exp == null) return true; 

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now >= exp; 
  } catch (e) {
    return true; 
  }
}

void logoutCleanUp()async{
  final storage = FlutterSecureStorage();

  await storage.delete(key: "accessToken");
      await storage.delete(key: "refreshToken");
      print("LOGOUT METHOD");
      var box = Hive.box('authBox');
      box.clear();
      // await box.delete('accessToken');
      // await box.delete('userId');
      // await box.delete('roleName');
      // await box.delete('isCustomer');
      // await box.delete('isSeller');

      LoginResponse.accessToken = null;
      LoginResponse.refreshToken = null;
      LoginResponse.userId = null;
      LoginResponse.roleName = null;
      LoginResponse.isCustomer = null;
      LoginResponse.isSeller = null;
      LoginResponse.currentCustomer = null;
}

String getTimeAgo(DateTime createdAt) {
  return timeago.format(createdAt, locale: 'en'); // Change locale if needed
}

String adjustImage(String image) {
  Uri uri = Uri.parse(image);
  Uri obj = uri.replace(host: '10.0.2.2');
  String path = obj.toString();
  return path;
}

List<String> adjustMultipleImages(List<Model.Image> images) {
  List<String> returnObj = [];
  for (var item in images) {
    returnObj.add(adjustImage(item.path!));
  }
  return returnObj;
}

Color hexToColor(String hexCode) {
  hexCode = hexCode.toUpperCase().replaceAll("#", ""); // Remove #
  if (hexCode.length == 6) {
    hexCode = "FF$hexCode"; // Add FF for full opacity
  }
  return Color(int.parse(hexCode, radix: 16));
}

List<Map<String, dynamic>> categoriesFromUtils = [
      {"icon": cameraIcon, "text": "Camera"},
      {"icon": pcIcon, "text": "PC"},
      {"icon": consoleIcon, "text": "Console"},
      {"icon": laptopIcon, "text": "Laptop"},
      {"icon": phoneIcon, "text": "Phone"},
      {"icon": tabletIcon, "text": "Tablet"},
      {"icon": tvIcon, "text": "TV"},
      {"icon": accessoryIcon, "text": "Accessory"},
    ];

 String categoryNameSelect(List<Map<String, dynamic>> categories, int index) {
    switch (categories[index]["text"]) {
      case "Camera":
        return "Camera";
      case "PC":
        return"Desktop PC";
      case "Console":
        return"Gaming Console";
      case "Laptop":
        return"Laptop";
      case "Phone":
        return"Phone";
      case "Tablet":
        return"Tablet";
      case "TV":
        return"Television";
    
      case "Accessory":
        return"Accessory";    
    }
    return "";
  }
  String categoryNameSelect2(String name) {
    switch (name) {
      case "Camera":
        return "Camera";
      case "PC":
        return"Desktop PC";
      case "Console":
        return"Gaming Console";
      case "Laptop":
        return"Laptop";
      case "Phone":
        return"Phone";
      case "Tablet":
        return"Tablet";
      case "TV":
        return"Television";
    
      case "Accessory":
        return"Accessory";    
    }
    return "";
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
    final storage = FlutterSecureStorage();
    String? baseUrl;
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
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

    Future<Map<String, String>> getHeaders({bool withAuth = true}) async {
      final storage = FlutterSecureStorage();
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