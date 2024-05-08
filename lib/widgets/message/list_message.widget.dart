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

class Interview {
  final String interviewId;
  final String createdAt;
  final String interviewTitle;
  final String startTime;
  final String endTime;
  final String meetingRoomId;
  final String meetingRoomCode;
  final String duration;

  Interview({
    required this.interviewId,
    required this.createdAt,
    required this.interviewTitle,
    required this.startTime,
    required this.endTime,
    required this.meetingRoomId,
    required this.meetingRoomCode,
    required this.duration,
  });

  Interview.fromJson(Map<dynamic, dynamic> json)
      : interviewId = json['interviewId'],
        createdAt = json['createdAt'],
        interviewTitle = json['interviewTitle'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        meetingRoomId = json['meetingRoomId'],
        meetingRoomCode = json['meetingRoomCode'],
        duration = json['duration'];

  Map<dynamic, dynamic> toJson() {
    return {
      'interviewId': interviewId,
      'createdAt': createdAt,
      'interviewTitle': interviewTitle,
      'startTime': startTime,
      'endTime': endTime,
      'meetingRoomId': meetingRoomId,
      'meetingRoomCode': meetingRoomCode,
      'duration': duration,
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
  List<Interview> listInterview = [];
  bool isFetchingData = false;
  int tabWidget = 1;

  void setTabWidget(int index) {
    setState(() {
      tabWidget = index;
    });
  }

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

  void getInterview(token, userId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetInterview = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/interview/user/$userId');

    final responseInterview = await http.get(
      urlGetInterview,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseInterviewData = json.decode(responseInterview.body);
    print('----responseInterviewData----');
    print(responseInterviewData['result']);

    List<Interview> listInterviewGetFromRes = [];
    if (responseInterviewData['result'] != null) {
      for (var item in responseInterviewData['result']) {
        listInterviewGetFromRes.add(Interview(
          interviewId: item['id'].toString(),
          createdAt: 'Created at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          interviewTitle: item['title'],
          startTime: 'Start at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['startTime']).toLocal(),
              ).toString()}',
          endTime: 'End at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['endTime']).toLocal(),
              ).toString()}',
          meetingRoomId: item['meetingRoom']['id'].toString(),
          meetingRoomCode: item['meetingRoom']['meeting_room_code'],
          duration: '${DateTime.parse(item['endTime']).difference(DateTime.parse(item['startTime'])).inMinutes} minutes',
        ));
      }
    }

    setState(() {
      listInterview = [...listInterviewGetFromRes];
      isFetchingData = false;
    });
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
    final projectId = ref.watch(projectIdProvider);
    return isFetchingData
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 300),
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
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(1);
                      getMessages(user.token, user.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 1
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 1 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 80),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(2);
                      getInterview(user.token, user.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 2
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Interview",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 2 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 610,
                child: tabWidget == 1
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            ...listMessages.reversed.map(
                              (el) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        ref.read(projectIdProvider.notifier).setProjectId(el.projectId.toString());

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
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ...listInterview.reversed.map(
                              (el) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 190,
                                                  child: Text(
                                                    el.interviewTitle,
                                                    style: const TextStyle(
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  el.duration,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              'Start time:  ${el.startTime}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'End time:  ${el.endTime}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Meeting room code:  ${el.meetingRoomCode}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Meeting room ID:  ${el.meetingRoomId}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: 110,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        ref.read(optionsProvider.notifier).setWidgetOption('Videocall', user.role!);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          side: const BorderSide(color: Colors.grey),
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
                                          ],
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
            ],
          );
  }
}
