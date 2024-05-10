import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

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
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/screens/message/video_conference.screen.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/language/language.provider.dart';

class Notification {
  final String id;
  final String notificationType;
  final String notificationContent;
  final String senderName;
  final String createdAt;
  final String typeNotifyFlag;
  final String proposalId;
  final String coverLetter;
  final String statusFlag;

  Notification({
    required this.id,
    required this.notificationType,
    required this.notificationContent,
    required this.senderName,
    required this.createdAt,
    required this.typeNotifyFlag,
    required this.proposalId,
    required this.coverLetter,
    required this.statusFlag,
  });

  Notification.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        notificationType = json['notificationType'],
        notificationContent = json['notificationContent'],
        senderName = json['senderName'],
        createdAt = json['createdAt'],
        typeNotifyFlag = json['typeNotifyFlag'],
        proposalId = json['proposalId'],
        coverLetter = json['coverLetter'],
        statusFlag = json['statusFlag'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'notificationType': notificationType,
      'notificationContent': notificationContent,
      'senderName': senderName,
      'createdAt': createdAt,
      'typeNotifyFlag': typeNotifyFlag,
      'proposalId': proposalId,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
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
        print('----item type notify flag----');
        print(item['typeNotifyFlag']);
        ref.read(notificationProvider.notifier).pushNotificationData(
              item['id'].toString(),
              item['notifyFlag'],
              item['typeNotifyFlag'] == '2' || item['typeNotifyFlag'] == '0' || item['typeNotifyFlag'] == '4'
                  ? '${item['content']}'
                  : item['typeNotifyFlag'] == '1'
                      ? '${item['content']}\nTitle: ${item['message']['interview']['title']}\nStart time: ${DateFormat("dd/MM/yyyy | HH:mm").format(
                            DateTime.parse(item['message']['interview']['startTime']),
                          ).toString()}\nEnd time: ${DateFormat("dd/MM/yyyy | HH:mm").format(
                            DateTime.parse(item['message']['interview']['endTime']),
                          ).toString()}\nMeeting room code: ${item['message']['interview']['meetingRoom']['meeting_room_code']}\nMeeting room id: ${item['message']['interview']['meetingRoom']['meeting_room_id']}'
                      : '${item['content']}\n${item['message']['content']}',
              item['sender']['fullname'],
              DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(item['createdAt']).toLocal()).toString(),
              item['typeNotifyFlag'],
              item['typeNotifyFlag'] == '0' ? item['proposalId'].toString() : '',
              item['typeNotifyFlag'] == '0' ? item['proposal']['coverLetter'] : '',
              item['typeNotifyFlag'] == '0' ? item['proposal']['statusFlag'].toString() : '',
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
    final student = ref.watch(studentProvider);
    final projectId = ref.watch(projectIdProvider);
    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);

    return Container(
      color: colorApp.colorBackgroundColor,
      child: SizedBox(
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
                                  if (el.typeNotifyFlag == '0' || el.typeNotifyFlag == '2') {
                                    ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
                                  } else {
                                    ref.read(optionsProvider.notifier).setWidgetOption('Message', user.role!);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(255, 232, 233, 237),
                                    border: Border.all(
                                      color: colorApp.colorBorderSide as Color,
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
                                                        style: TextStyle(
                                                          color: colorApp.colorTime,
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
                                                    style: TextStyle(
                                                      color: colorApp.colorTitle,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 240,
                                                  child: Text(
                                                    el.notificationContent,
                                                    style: TextStyle(
                                                      color: colorApp.colorText,
                                                      // overflow: TextOverflow.ellipsis,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                el.typeNotifyFlag == '0' && el.statusFlag == '2'
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          const SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 115,
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                width: 130,
                                                                child: ElevatedButton(
                                                                  onPressed: () async {
                                                                    print('------proposal id ------');
                                                                    print(el.proposalId);
                                                                    final urlUpdateProposals = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/proposal/${el.proposalId}');

                                                                    final responseUpdateProposals = await http.patch(
                                                                      urlUpdateProposals,
                                                                      headers: {
                                                                        'Content-Type': 'application/json',
                                                                        'Authorization': 'Bearer ${user.token}',
                                                                      },
                                                                      body: json.encode({
                                                                        "coverLetter": el.coverLetter,
                                                                        "statusFlag": 3,
                                                                        "disableFlag": 0,
                                                                      }),
                                                                    );
                                                                    print('----responseUpdateProposals----');
                                                                    print(json.decode(responseUpdateProposals.body));
                                                                    // Navigator.pop(context);
                                                                    getNotifications(user.token, projectId, user.id);
                                                                    showSuccessToast('Success', 'Offer has been accepted successfully');
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      side: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                    ),
                                                                    backgroundColor: colorApp.colorBlackWhite,
                                                                  ),
                                                                  child: Text(
                                                                    Language.Accept,
                                                                    style: TextStyle(
                                                                      fontSize: 16,
                                                                      color: colorApp.colorWhiteBlack,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(height: 0),
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
      ),
    );
  }
}
