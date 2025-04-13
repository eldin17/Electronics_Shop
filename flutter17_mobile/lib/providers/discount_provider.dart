import 'package:flutter17_mobile/models/discount.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscountProvider extends BaseCRUDProvider<Discount> {

  DiscountProvider() : super("api/Discount") ;

  @override
  Discount fromJson(data){
    return Discount.fromJson(data);
  }

  Future<Discount> getOneRandom() async {
    var url = "$baseUrl$endpoint/GetOneRandom";

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
        print(result.toString());

        return result;
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }  
}