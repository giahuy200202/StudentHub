import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';

class WelcomeWidget extends ConsumerStatefulWidget {
  const WelcomeWidget({super.key});

  @override
  ConsumerState<WelcomeWidget> createState() {
    return _WelcomeWidget();
  }
}

class _WelcomeWidget extends ConsumerState<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/black.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // const Icon(
                //   Icons.cast_for_education,
                //   size: 200,
                //   color: Color.fromARGB(255, 144, 134, 134),
                // ),
                const SizedBox(height: 400),
                const Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 400,
                    child: Text(
                      'Welcome, ',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 400,
                    child: Text(
                      'Pham Vo Cuong',
                      style: TextStyle(
                          fontSize: 48,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Get ready to optimize your academic journey with Student Hub, the ultimate mobile app for students. Seamlessly manage schedules, assignments, and connect with peers effortlessly. Start maximizing your academic success today',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(optionsProvider.notifier)
                          .setWidgetOption('Dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
