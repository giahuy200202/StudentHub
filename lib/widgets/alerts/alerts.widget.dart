import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/message/receive_id.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';

import 'package:toastification/toastification.dart';

class AlertsWidget extends ConsumerStatefulWidget {
  const AlertsWidget({super.key});

  @override
  ConsumerState<AlertsWidget> createState() {
    return _AlertsWidget();
  }
}

class _AlertsWidget extends ConsumerState<AlertsWidget> {
  bool isFetchingData = false;

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

    // List<Message> listMessagesGetFromRes = [];
    // if (responseNotificationsData['result'] != null) {
    //   for (var item in responseNotificationsData['result']) {
    //     listMessagesGetFromRes.add(Message(
    //       createdAt: DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(item['createdAt']).toLocal()).toString(),
    //       author: item['sender']['fullname'],
    //       content: item['content'],
    //       isInterview: false,
    //     ));
    //   }
    // }

    // print('----listMessagesGetFromRes----');
    // print(json.encode(listMessagesGetFromRes));

    setState(() {
      // listMessages = [...listMessagesGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);
    final projectId = ref.read(projectIdProvider);
    final receiveId = ref.read(receiveIdProvider);

    getNotifications(user.token!, projectId, user.id!);

    final socket = IO.io(
        'https://api.studenthub.dev/', // Server url
        OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

    //Add authorization to header
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer ${user.token}',
    };

    //Add query param to url
    socket.io.options?['query'] = {'project_id': projectId};

    socket.connect();

    socket.onConnect((data) => {print('Connected')});
    socket.onDisconnect((data) => {print('Disconnected')});

    socket.onConnectError((data) => print('$data'));
    socket.onError((data) => print(data));

    //Listen to channel receive message
    socket.on('RECEIVE_MESSAGE', (data) {
      // Your code to update ui

      print('------RECEIVE_MESSAGE------');
      print(data);

      // if (mounted) {
      //   setState(() {});
      // }
    });
    //Listen for error from socket
    socket.on("ERROR", (data) => print(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
                child: Column(children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 600,
                width: 400,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                    alignment: Alignment.topLeft,
                                    width: 70,
                                    height: 70,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/avatar.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 160,
                                    width: 240,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '6/6/2024',
                                          style: TextStyle(fontSize: 13, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 5),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 300,
                                            child: Text(
                                              maxLines: 3,
                                              'You have Invited to interview for project "Javis - AI Copllot at 14:00 March 20, Thrusday"',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 27),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            height: 40,
                                            width: 130,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                  side: const BorderSide(color: Colors.black),
                                                ),
                                                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                              ),
                                              child: const Text(
                                                'Join',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              )
            ]))));
  }
}
