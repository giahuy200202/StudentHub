import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/message/receive_id.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';

import '../../providers/options.provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:toastification/toastification.dart';

class Message {
  final String projectId;
  final String projectTitle;
  final String createdAt;
  final String receiverName;
  final String content;
  final String receiverId;
  final bool isInterview;

  Message({
    required this.projectId,
    required this.projectTitle,
    required this.createdAt,
    required this.receiverName,
    required this.content,
    required this.receiverId,
    required this.isInterview,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : projectId = json['projectId'],
        projectTitle = json['projectTitle'],
        createdAt = json['createdAt'],
        receiverName = json['receiverName'],
        content = json['content'],
        receiverId = json['receiverId'],
        isInterview = json['isInterview'];

  Map<dynamic, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectTitle': projectTitle,
      'createdAt': createdAt,
      'receiverName': receiverName,
      'content': content,
      'receiverId': receiverId,
      'isInterview': isInterview,
    };
  }
}

class MessageWidget extends ConsumerStatefulWidget {
  const MessageWidget({super.key});

  @override
  ConsumerState<MessageWidget> createState() {
    return _MessageWidgetState();
  }
}

class _MessageWidgetState extends ConsumerState<MessageWidget> {
  List<Message> listMessages = [];
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

  void getMessages(token, userId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetMessages = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/message');

    final responseMessages = await http.get(
      urlGetMessages,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseMessagesData = json.decode(responseMessages.body);
    print('----responseMessagesData----');
    print(responseMessagesData['result']);

    List<Message> listMessagesGetFromRes = [];
    if (responseMessagesData['result'] != null) {
      for (var item in responseMessagesData['result']) {
        listMessagesGetFromRes.add(Message(
          projectId: item['project']['id'].toString(),
          projectTitle: item['project']['title'],
          createdAt: 'Created at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          receiverName: item['receiver']['id'] == userId ? item['sender']['fullname'] : item['receiver']['fullname'],
          content: item['content'],
          receiverId: item['receiver']['id'] == userId ? item['sender']['id'].toString() : item['receiver']['id'].toString(),
          isInterview: false,
        ));
      }
    }

    setState(() {
      listMessages = [...listMessagesGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    getMessages(user.token!, user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SizedBox(
      height: 650,
      width: MediaQuery.of(context).size.width,
      child: isFetchingData
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0),
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
              child: Column(
                children: [
                  ...listMessages.map(
                    (el) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ref.read(projectIdProvider.notifier).setProjectId(el.projectId);
                              ref.read(receiveIdProvider.notifier).setReceiveId(el.receiverId);
                              ref.read(optionsProvider.notifier).setWidgetOption('MessageDetails', user.role!);
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
                                      children: [
                                        Container(
                                          width: 65,
                                          height: 65,
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
                                            SizedBox(
                                              width: 250,
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                el.receiverName,
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
                                                el.createdAt,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(255, 115, 114, 114),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 240,
                                              child: Text(
                                                el.projectTitle,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black, //                   <--- border color
                                          width: 0.3,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        el.content,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
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
    );
  }
}
