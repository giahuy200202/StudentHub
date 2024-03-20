import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:studenthub/providers/options_provider.dart';

class MessageDetailsWidget extends ConsumerStatefulWidget {
  const MessageDetailsWidget({super.key});
  @override
  ConsumerState<MessageDetailsWidget> createState() {
    return _MessageDetailsWidget();
  }
}

class _MessageDetailsWidget extends ConsumerState<MessageDetailsWidget> {
  var SendMessage = TextEditingController();
  bool enable = false;
  @override
  void dispose() {
    SendMessage.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enterMessage = SendMessage.text;
    if (enterMessage.trim().isEmpty) {
      return;
    }
    SendMessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: SendMessage,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            )),
            IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: _submitMessage,
                icon: const Icon(Icons.send))
          ],
        ));
  }
}
