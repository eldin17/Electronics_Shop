import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
 
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class ImageUploadProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "api/Image";

  ImageUploadProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
  }

  Future<void> addSingleImage(int id, File image) async {
    try {
      var url = "$_baseUrl$_endpoint/AddSingleImage/$id";

      final dioOptions = dio.BaseOptions(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ${LoginResponse.token}',
        },
      );
      final dioClient = dio.Dio(dioOptions);

      final formData = dio.FormData();

      final fileName = path.basename(image.path);
      formData.files.add(
        MapEntry(
          'vmImage',
          await dio.MultipartFile.fromFile(
            image.path,
            filename: fileName,
            contentType: MediaType('image', 'jpeg'),
          ),
        ),
      );

      final response = await dioClient.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Image uploaded successfully
        print('Image uploaded');
      } else {
        // Handle error
        print('Failed to upload image');
      }
    } catch (error) {
      // Handle error
      print('Failed to upload image: $error');
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
