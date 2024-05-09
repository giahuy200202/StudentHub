import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import '../../providers/options.provider.dart';

class MessageWidget extends ConsumerStatefulWidget {
  const MessageWidget({super.key});

  @override
  ConsumerState<MessageWidget> createState() {
    return _MessageWidgetState();
  }
}

class _MessageWidgetState extends ConsumerState<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    var colorApp = ref.watch(colorProvider);
    return Text(
      'Message',
      style: TextStyle(color: colorApp.colorText),
    );
  }
}
