import 'package:flutter17_mobile/models/coupon.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CouponProvider extends BaseCRUDProvider<Coupon> {

  CouponProvider() : super("api/Coupon") ;

  @override
  Coupon fromJson(data){
    return Coupon.fromJson(data);
  }

  Future<Coupon> couponCheck({dynamic obj}) async {
    var url = "${baseUrl}api/Coupon/CouponCheck";

    if (obj != null) {
      var queryString = getQueryString(obj);
      url = "$url?$queryString";
    }

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