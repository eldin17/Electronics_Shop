import 'package:flutter/material.dart';
import 'package:flutter17_mobile/models/notification.dart' as Model;
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:flutter17_mobile/models/search_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:signalr_netcore/signalr_client.dart';

import '../helpers/login_response.dart';
import '../main.dart';

class NotificationProvider extends BaseCRUDProvider<Model.Notification> {
  HubConnection? _hubConnection;
  bool _hasNewNotification = false;
  NotificationProvider() : super("api/Notification");

  @override
  Model.Notification fromJson(data) {
    return Model.Notification.fromJson(data);
  }

  bool get hasNewNotification => _hasNewNotification;

  void initSignalR() async {
    if (_hubConnection?.state == HubConnectionState.Connected) return;
    final accessToken = await storage.read(key: "accessToken");
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          "${baseUrl}notificationHub",
          options: HttpConnectionOptions(
            accessTokenFactory: () async => accessToken ?? "",
          ),
        )
        .withAutomaticReconnect()
        .build();

    _hubConnection!.on("ReceiveNotification", (arguments) {
      final data = arguments![0] as Map<String, dynamic>;

      _hasNewNotification = true;
      notifyListeners();

      _showTopPopup(data['title'] ?? "New Notification", data['content'] ?? "");

      print("--- SIGNALR NOTIFICATION RECEIVED ---");
      print("Payload: $data");
      print("---------------------------------------");
    });

    _hubConnection!.start()?.then((_) {
      print("SignalR: Connected to Hub successfully.");
    }).catchError((error) {
      print("SignalR Error: $error");
    });
  }

  void _showTopPopup(String title, String content) {
    print("SignalR: POPUP");

    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 2500),
          elevation: 12,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🎉 $title',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 80, 80, 80),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
        ),
      );
    }
  }

  void clearNotificationFlag() {
    _hasNewNotification = false;
    notifyListeners();
  }

  Future<SearchResult<Model.Notification>> getAllForUser(int userAccountId,
      {dynamic filter}) async {
    var url = "${baseUrl}api/Notification/GetAllForUser/${userAccountId}";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var headers = await getHeaders(withAuth: true);

    var uri = Uri.parse(url);

    try {
      var response =
          await sendWithRefresh((headers) => http.get(uri, headers: headers));
      // var response = await http.get(
      //   uri,
      //   headers: headers,
      // );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        var result = SearchResult<Model.Notification>();
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

  Future<Model.Notification> AddForUser(dynamic obj) async {
    var url = "${baseUrl}api/Notification/AddForUser";
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

  Future<String> MarkAsRead(int userAccId, int notificationId) async {
    var url =
        "${baseUrl}api/Notification/MarkAsRead/${userAccId}/${notificationId}";
    var uri = Uri.parse(url);

    var headers = await getHeaders(withAuth: true);

    try {
      var response =
          await sendWithRefresh((headers) => http.post(uri, headers: headers));
      //var response = await http.post(uri, headers: headers);

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
