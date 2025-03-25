
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/models/image.dart' as Model;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

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
        return"DesktopPC";
      case "Console":
        return"GamingConsole";
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
        return"DesktopPC";
      case "Console":
        return"GamingConsole";
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