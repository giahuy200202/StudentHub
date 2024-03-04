import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/login.widget.dart';
import 'package:studenthub/widgets/switch_account.widget.dart';

class SwitchAccountScreen extends ConsumerWidget {
  const SwitchAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SwitchAccountWidget();
  }
}
