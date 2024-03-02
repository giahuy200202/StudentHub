import 'package:flutter/material.dart';
import 'package:studenthub/screens/homepage.screen.dart';
import 'package:studenthub/screens/login.screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/signup_step1.widget.dart';
import 'package:studenthub/widgets/top_navbar.widget.dart';

class LayoutScreen extends ConsumerWidget {
  const LayoutScreen({super.key});

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
      body: const SignupStep1(),
    );
  }
}
