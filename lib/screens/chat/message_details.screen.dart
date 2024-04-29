import 'package:flutter/material.dart';
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
  @override
  void dispose() {
    sendMessage.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enterMessage = sendMessage.text;
    print(enterMessage);
    if (enterMessage.trim().isEmpty) {
      return;
    }
    sendMessage.clear();
  }

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
                SizedBox(height: 365),
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
                    const SizedBox(
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
                              print(company.id);
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
                              });
                              //Listen for error from socket
                              socket.on("ERROR", (data) => print(data));
                              socket.emit("SEND_MESSAGE", {
                                "content": enterMessage,
                                "projectId": projectId,
                                "senderId": company.id,
                                "receiverId": receiveId,
                                "messageFlag": 0 // default 0 for m123essage, 1 for interview
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
