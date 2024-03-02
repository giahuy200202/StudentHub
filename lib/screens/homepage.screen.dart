import 'package:flutter/material.dart';
import 'package:studenthub/widgets/homepage.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomepageScreen extends ConsumerWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomepageWidget();
  }
}
