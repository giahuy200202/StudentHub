import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/widgets/message/message_details.widget.dart';
import 'package:studenthub/widgets/message/body_message.widget.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/widgets/message/BottomSheet.widget.dart';

class MessageDetailsScreen extends ConsumerStatefulWidget {
  const MessageDetailsScreen({super.key});

  @override
  ConsumerState<MessageDetailsScreen> createState() {
    return _MessageDetailsScreen();
  }
}

class _MessageDetailsScreen extends ConsumerState<MessageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ShowbottomSheduleWidget()),
        body: Column(
          children: [
            Expanded(child: ChatMessageDetailsWidget()),
            MessageDetailsWidget()
          ],
        ));
  }
}
