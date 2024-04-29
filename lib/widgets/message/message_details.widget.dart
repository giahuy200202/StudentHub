import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
// import 'package:studenthub/providers/options_provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageDetailsWidget extends ConsumerStatefulWidget {
  const MessageDetailsWidget({super.key});
  @override
  ConsumerState<MessageDetailsWidget> createState() {
    return _MessageDetailsWidget();
  }
}

class _MessageDetailsWidget extends ConsumerState<MessageDetailsWidget> {
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
    return Padding(
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
            onPressed: _submitMessage,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
