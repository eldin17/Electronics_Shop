import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection _hubConnection;
  
  final String _url = "http://10.0.2.2:5116/notificationHub";

  void startConnection(String token) { 
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          _url,
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token,
          ),
        )
        .withAutomaticReconnect()
        .build();

    _hubConnection.on("ReceiveNotification", (arguments) {
      final data = arguments![0];

      print("--- SIGNALR NOTIFICATION RECEIVED ---");
      print("Payload: $data");
      print("---------------------------------------");
    });
    
    _hubConnection.start()?.then((_) {
      print("SignalR: Connected to Hub successfully.");
    }).catchError((error) {
      print("SignalR Error: $error");
    });
  }

  void stopConnection() {
    _hubConnection.stop();
  }
}
