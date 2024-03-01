import 'package:flutter/material.dart';
import 'package:studenthub/providers/option_provider.dart';
import 'package:studenthub/widgets/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final options = ref.watch(optionsProvider);
    // return options[Option.categoryOption] == ''
    //     ? const HomeWidget()
    //     : TaskScreen(option: options[Option.categoryOption]!);

    return const HomeWidget();
  }
}
