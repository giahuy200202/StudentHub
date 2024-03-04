import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeCompanyWidget extends ConsumerStatefulWidget {
  const WelcomeCompanyWidget({super.key});

  @override
  ConsumerState<WelcomeCompanyWidget> createState() {
    return _WelcomeCompanyWidget();
  }
}

class _WelcomeCompanyWidget extends ConsumerState<WelcomeCompanyWidget> {
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
                    height: 60,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Get Started! ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
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
