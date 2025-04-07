import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/providers/notification_provider.dart';
import 'package:flutter17_mobile/screens/notification_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter17_mobile/models/notification.dart' as Model;

import '../helpers/utils.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  bool isLoading = true;
  late NotificationProvider _notificationProvider;
  List<Model.Notification> notificationsList = [];

  @override
  void initState() {
    super.initState();
    _notificationProvider = context.read<NotificationProvider>();
    initForm();
  }

  Future initForm() async {
    var notification =
        await _notificationProvider.getAllForUser(LoginResponse.userId ?? 0);

    setState(() {
      notificationsList = List<Model.Notification>.from(notification.data);
      print(
          "notifications -> ${notificationsList.length} for userAcc -> ${LoginResponse.userId}\n ${LoginResponse.currentCustomer?.id}");
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 500, // Maximum height before scrolling
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: // Loading Indicator
                    notificationsList.isEmpty
                        ? const Center(
                            child: Text(
                                "No notifications? That’s a good thing… right?"))
                        : ListView.builder(
                            shrinkWrap: true, // Makes it take only needed space
                            physics:
                                const BouncingScrollPhysics(), // Smooth scrolling
                            itemCount: notificationsList.length,
                            itemBuilder: (context, index) => NotifCard(
                              notification: notificationsList[index],
                              press: () async {
                                await _notificationProvider.MarkAsRead(
                                    LoginResponse.userId!,
                                    notificationsList[index].id!);

                                Navigator.of(context)
                                    .push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        NotificationDetailsScreen(
                                      notification: notificationsList[index],
                                    ),
                                  ),
                                )
                                    .then((_) {
                                  setState(() {
                                    initForm();
                                  });
                                });
                              },
                            ),
                          ),
              ),
            ),
          );
  }
}

class NotifCard extends StatelessWidget {
  const NotifCard({
    super.key,
    required this.notification,
    required this.press,
  });

  final Model.Notification notification;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0 * 0.75),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        notification.message ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(getTimeAgo(notification.dateCreated!) ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
