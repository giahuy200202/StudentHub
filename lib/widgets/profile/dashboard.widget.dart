import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/options_provider.dart';

class DashboardWidget extends ConsumerStatefulWidget {
  const DashboardWidget({super.key});

  @override
  ConsumerState<DashboardWidget> createState() {
    return _DashboardWidgetState();
  }
}

class _DashboardWidgetState extends ConsumerState<DashboardWidget> {
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Your jobs!',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 43,
                      width: 121,
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(optionsProvider.notifier)
                              .setWidgetOption('ProjectPostStep1');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.black),
                          ),
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: const Text(
                          'Post a job',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome, Hai!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "You have no job!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
