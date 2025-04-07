import 'dart:convert';

import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/search_result.dart';

class ProductProvider extends BaseCRUDProvider<Product> {
  ProductProvider() : super("api/Product");

  @override
  Product fromJson(data) {
    return Product.fromJson(data);
  }

  Future<SearchResult<dynamic>> getAllWithChecks(int customerid,
      {dynamic filter}) async {
    var url = "${baseUrl}api/Product/GetAllWithChecks/$customerid";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);

    print(uri);

    try {
      var response = await http.get(
        uri,
        headers: headers,
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        var result = SearchResult<dynamic>();
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

  Future<dynamic> getByIdWithChecks(int customerId, int id) async {
    var url = "${baseUrl}api/Product/GetByIdWithChecks/${customerId}/${id}";

    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);

    try {
      var response = await http.get(
        uri,
        headers: headers,
      );

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
}
