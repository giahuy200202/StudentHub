import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/notifications/local_notification.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/message/receive_id.provider.dart';
import 'package:studenthub/providers/notification/notifications.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';

import 'package:toastification/toastification.dart';

class Notification {
  final String id;
  final String notificationType;
  final String notificationContent;
  final String senderName;
  final String createdAt;

  Notification({
    required this.id,
    required this.notificationType,
    required this.notificationContent,
    required this.senderName,
    required this.createdAt,
  });

  Notification.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        notificationType = json['notificationType'],
        notificationContent = json['notificationContent'],
        senderName = json['senderName'],
        createdAt = json['createdAt'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'notificationType': notificationType,
      'notificationContent': notificationContent,
      'senderName': senderName,
      'createdAt': createdAt,
    };
  }
}

class AlertsWidget extends ConsumerStatefulWidget {
  const AlertsWidget({super.key});

  @override
  ConsumerState<AlertsWidget> createState() {
    return _AlertsWidget();
  }
}

class _AlertsWidget extends ConsumerState<AlertsWidget> {
  bool isFetchingData = false;
  List<Notification> listNotifications = [];

  void showErrorToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void showSuccessToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void getNotifications(token, projectId, userId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlgetNotifications = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/notification/getByReceiverId/$userId');

    final responseNotifications = await http.get(
      urlgetNotifications,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseNotificationsData = json.decode(responseNotifications.body);
    print('----responseNotificationsData----');
    print(responseNotificationsData);

    if (responseNotificationsData['result'] != null) {
      ref.read(notificationProvider.notifier).clearNotificationData();

      for (var item in responseNotificationsData['result']) {
        ref.read(notificationProvider.notifier).pushNotificationData(
              item['id'].toString(),
              item['notifyFlag'],
              item['content'],
              item['sender']['fullname'],
              DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(item['createdAt']).toLocal()).toString(),
            );
      }
    }

    // print('----listNotificationsGetFromRes----');
    // print(json.encode(listNotificationsGetFromRes));

    setState(() {
      // listNotifications = [...listNotificationsGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);
    final projectId = ref.read(projectIdProvider);

    getNotifications(user.token!, projectId, user.id!);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    final listNotifications = ref.watch(notificationProvider);

    return SizedBox(
      height: 700,
      width: MediaQuery.of(context).size.width,
      child: isFetchingData
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    ...listNotifications.reversed.map(
                      (el) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // ref.read(optionsProvider.notifier).setWidgetOption('NotificationDetails', user.role!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Color.fromARGB(255, 232, 233, 237),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.4,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            margin: const EdgeInsets.only(top: 3),
                                            padding: const EdgeInsets.all(20),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/avatar.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 240,
                                                    child: Text(
                                                      el.createdAt,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(255, 115, 114, 114),
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                  el.notificationType == '0'
                                                      ? const Icon(
                                                          Icons.circle,
                                                          color: Colors.grey,
                                                          size: 10,
                                                        )
                                                      : const Icon(
                                                          Icons.circle,
                                                          color: Colors.white,
                                                          size: 10,
                                                        ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  textAlign: TextAlign.start,
                                                  el.senderName,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 240,
                                                child: Text(
                                                  el.notificationContent,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
