import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';

import '../../providers/options.provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:toastification/toastification.dart';

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

  void getMessages(token) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetMessages = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/message');

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
    // if (responseMessagesData['result'] != null) {
    //   for (var item in responseMessagesData['result']) {
    //     listMessagesGetFromRes.add(Message(
    //       projectId: item['projectId'].toString(),
    //       projectTitle: item['projectTitle'],
    //       updateTime: 'Created at ${DateFormat("dd/MM/yyyy | HH:mm").format(
    //             DateTime.parse(item['updateTime']).toLocal(),
    //           ).toString()}',
    //       senderName: item['senderName'],
    //       content: item['content'],
    //     ));
    //   }
    // }

    setState(() {
      listMessages = [...listMessagesGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    getMessages(user.token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    'Luis Pham',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 240,
                                  child: Text(
                                    '12/04/2020 | 14:07',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 115, 114, 114),
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Senior frontend developer (Fintech)',
                                    style: TextStyle(
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
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Clear expectation about your project or dellverables',
                            style: TextStyle(
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
          ),
        ));
  }
}
