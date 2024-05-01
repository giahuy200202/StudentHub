import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/message/receive_id.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/widgets/message/message_details.widget.dart';
import 'package:studenthub/widgets/message/body_message.widget.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/widgets/message/BottomSheet.widget.dart';
import 'package:studenthub/widgets/message/schedule.widget.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class Message {
  final String createdAt;
  final String author;
  final String content;

  Message({
    required this.createdAt,
    required this.author,
    required this.content,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : createdAt = json['createdAt'],
        author = json['author'],
        content = json['content'];

  Map<dynamic, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'author': author,
      'content': content,
    };
  }
}

class MessageDetailsScreen extends ConsumerStatefulWidget {
  const MessageDetailsScreen({super.key});

  @override
  ConsumerState<MessageDetailsScreen> createState() {
    return _MessageDetailsScreen();
  }
}

class _MessageDetailsScreen extends ConsumerState<MessageDetailsScreen> {
  bool isFetchingData = false;

  var sendMessage = TextEditingController();
  bool enable = false;

  List<Message> listMessages = [];

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

  void getMessages(token, projectId, receiveId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetMessages = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/message/$projectId/user/$receiveId');

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
          createdAt: DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(item['createdAt']).toLocal()).toString(),
          author: item['sender']['fullname'],
          content: item['content'],
        ));
      }
    }

    print('----listMessagesGetFromRes----');
    print(json.encode(listMessagesGetFromRes));

    setState(() {
      listMessages = [...listMessagesGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    final projectId = ref.read(projectIdProvider);
    final receiveId = ref.read(receiveIdProvider);

    getMessages(user.token!, projectId, receiveId);

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
    final user = ref.watch(userProvider);
    final projectId = ref.watch(projectIdProvider);
    final company = ref.watch(companyProvider);
    final receiveId = ref.watch(receiveIdProvider);

    return SingleChildScrollView(
      child: isFetchingData
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 420),
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              ref.read(optionsProvider.notifier).setWidgetOption('Message', user.role!);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Message details',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 650,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...listMessages.map((el) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/avatar.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 160,
                                                      child: Text(
                                                        el.author,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      el.createdAt,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(255, 119, 118, 118),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                              width: 300,
                                              child: Text(
                                                el.content,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: sendMessage,
                            textCapitalization: TextCapitalization.sentences,
                            autocorrect: true,
                            enableSuggestions: true,
                            decoration: const InputDecoration(labelText: 'Send a message...'),
                          )),
                          IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              final enterMessage = sendMessage.text;
                              print('------project id-------');
                              print(projectId);
                              print('------send id-------');
                              print(user.id);
                              print('------receive id-------');
                              print(receiveId);
                              if (enterMessage.trim().isEmpty) {
                                return;
                              }
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
                                // getMessages(user.token!, projectId, receiveId);
                                print('update ui');
                              });
                              //Listen for error from socket
                              socket.on("ERROR", (data) => print(data));
                              socket.emit("SEND_MESSAGE", {
                                "content": enterMessage,
                                "projectId": projectId,
                                "senderId": user.id,
                                "receiverId": receiveId,
                                "messageFlag": 0 // default 0 for message, 1 for interview
                              });

                              setState(() {
                                listMessages = [
                                  ...listMessages,
                                  Message(
                                    createdAt: DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.now().toLocal()).toString(),
                                    author: company.companyName!,
                                    content: enterMessage,
                                  )
                                ];
                              });

                              sendMessage.clear();
                            },
                            icon: const Icon(Icons.send),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
