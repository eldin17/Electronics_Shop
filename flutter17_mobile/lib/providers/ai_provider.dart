import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/coupon.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart';

import '../helpers/utils.dart';

class AiProvider with ChangeNotifier {
  String? baseUrl;
  String endpoint = "api/SummaryAI";
  final storage = FlutterSecureStorage();
  AiProvider() {
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5116/");
  }

  @override
  Coupon fromJson(data) {
    return Coupon.fromJson(data);
  }

  Future<Map<String, dynamic>> getProductReviewSummary({
    required int productId,
    bool forceRefresh = false,
  }) async {
    var url = "${baseUrl}api/SummaryAI/$productId/reviews-summary";

    url = "$url?forceRefresh=$forceRefresh";

    var headers = await getHeaders(withAuth: true);
    var uri = Uri.parse(url);

    try {
      var response = await sendWithRefresh(
        (headers) => http.get(uri, headers: headers),
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        
        String? summaryText = data['summary'] ?? data['Summary'];

        if (summaryText != null) {
          return {"summary": summaryText};
        }
      }
    } catch (e) {
      throw Exception("Failed to fetch AI summary: ${e.toString()}");
    }

    throw Exception("Unknown error fetching AI summary.");
  }
}
