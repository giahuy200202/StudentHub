import 'package:flutter/material.dart';
import 'package:studenthub/providers/option_provider.dart';
import 'package:studenthub/widgets/homepage.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/top_navbar.widget.dart';

class HomepageScreen extends ConsumerWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.black, Color.fromARGB(255, 73, 80, 87)],
            ),
          ),
          child: const TopNavbar(),
        ),
      ),
      body: const Center(
        child: Text('Content'),
      ),
    );
  }
}
