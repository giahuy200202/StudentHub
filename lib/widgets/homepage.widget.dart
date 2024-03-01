import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/tasks_provider.dart';

class HomepageWidget extends ConsumerWidget {
  const HomepageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final tasks = ref.watch(tasksProvider);
    return const Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 200),
            child: Text('Hello')),
      ),
    );
  }
}
