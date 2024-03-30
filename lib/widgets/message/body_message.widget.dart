import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/widgets/message/schedule.widget.dart';

class ChatMessageDetailsWidget extends ConsumerStatefulWidget {
  const ChatMessageDetailsWidget({super.key});
  @override
  ConsumerState<ChatMessageDetailsWidget> createState() {
    return _ChatMessageDetailsWidget();
  }
}

class _ChatMessageDetailsWidget
    extends ConsumerState<ChatMessageDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowscheduleWidget(),
            ]));
  }
}
