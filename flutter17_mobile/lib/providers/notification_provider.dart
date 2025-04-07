import 'package:flutter17_mobile/models/notification.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:flutter17_mobile/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationProvider extends BaseCRUDProvider<Notification> {
  NotificationProvider() : super("api/Notification");

  @override
  Notification fromJson(data) {
    return Notification.fromJson(data);
  }

  Future<SearchResult<Notification>> getAllForUser(int userAccountId,
      {dynamic filter}) async {
    var url = "${baseUrl}api/Notification/GetAllForUser/${userAccountId}";

    if (filter != null) {
      var queryString = getQueryString(filter);
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

        var result = SearchResult<Notification>();
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

  Future<Notification> AddForUser(dynamic obj) async {
    var url = "${baseUrl}api/Notification/AddForUser";
    var uri = Uri.parse(url);

    var headers = getHeaders(withAuth: true);

    var send = jsonEncode(obj);

    print("ADD ADD ADD $uri $send");
    try {
      var response = await http.post(uri, headers: headers, body: send);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }

  Future<String> MarkAsRead(int userAccId, int notificationId) async {
    var url = "${baseUrl}api/Notification/MarkAsRead/${userAccId}/${notificationId}";
    var uri = Uri.parse(url);

    var headers = getHeaders(withAuth: true);


    try {
      var response = await http.post(uri, headers: headers);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
    throw Exception();
  }
}
