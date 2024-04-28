import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/widgets/message/schedule.widget.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:toastification/toastification.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class Message {
  final String projectId;
  final String projectTitle;
  final String updateTime;
  final String senderName;
  final String content;

  Message({
    required this.projectId,
    required this.projectTitle,
    required this.updateTime,
    required this.senderName,
    required this.content,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : projectId = json['projectId'],
        projectTitle = json['projectTitle'],
        updateTime = json['updateTime'],
        senderName = json['senderName'],
        content = json['content'];

  Map<dynamic, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectTitle': projectTitle,
      'updateTime': updateTime,
      'senderName': senderName,
      'content': content,
    };
  }
}

class ChatMessageDetailsWidget extends ConsumerStatefulWidget {
  const ChatMessageDetailsWidget({super.key});
  @override
  ConsumerState<ChatMessageDetailsWidget> createState() {
    return _ChatMessageDetailsWidget();
  }
}

class _ChatMessageDetailsWidget extends ConsumerState<ChatMessageDetailsWidget> {
  @override
  void initState() {
    final user = ref.read(userProvider);
    final projectId = ref.read(projectIdProvider);
    print('------------chay dc o day-------------');

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
    });
    //Listen for error from socket
    socket.on("ERROR", (data) => print(data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 650,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowscheduleWidget(),
            SizedBox(height: 20),
            ShowscheduleWidget(),
            ShowscheduleWidget(),
            ShowscheduleWidget(),
          ],
        ),
      ),
    );
  }
}
