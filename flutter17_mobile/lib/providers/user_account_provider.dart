import 'dart:convert';

import 'package:flutter17_mobile/models/reset_pw.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;

class UserAccountProvider extends BaseCRUDProvider<UserAccount> {

  UserAccountProvider() : super("api/UserAccount") ;

  @override
  UserAccount fromJson(data){
    return UserAccount.fromJson(data);
  }

  Future<UserAccount> resetPW(ResetPW obj) async {
    var url = "$baseUrl$endpoint/resetPW";

    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);
    var objEncoded = jsonEncode(obj);
    var body = objEncoded;

    try {
      var response = await http.put(
        uri,
        headers: headers,
        body: body,
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        return fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }

  Future<UserAccount> deactivate(int id) async {
    var url = "$baseUrl$endpoint/deactivate/$id";

    var headers = getHeaders(withAuth: true);

    var uri = Uri.parse(url);
    

    try {
      var response = await http.put(
        uri,
        headers: headers,
      );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        return fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }
}