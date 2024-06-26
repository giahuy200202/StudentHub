import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/message/list_message.widget.dart';
//import '../../providers/options_provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState<MessageScreen> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var coloApp = ref.watch(colorProvider);
    return Scaffold(
      backgroundColor: coloApp.colorBackgroundColor,
      body: const Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              MessageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
