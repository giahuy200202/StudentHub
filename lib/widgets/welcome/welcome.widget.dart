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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                const Icon(
                  Icons.linked_camera,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 50,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                const SizedBox(height: 30),
                const Text(
                  'Welcome Hai!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Let's start with your frist project post  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: 145,
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(optionsProvider.notifier)
                            .setWidgetOption('Dashboard');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text(
                        'Get started!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
