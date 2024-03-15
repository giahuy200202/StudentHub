import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/profile/image_input.dart';

class ProfileIStudent_step3Widget extends ConsumerStatefulWidget {
  const ProfileIStudent_step3Widget({super.key});

  @override
  ConsumerState<ProfileIStudent_step3Widget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget
    extends ConsumerState<ProfileIStudent_step3Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'CV & Transcript',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tell us about your self and you will be your way connect with real-world project',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text('Resume/CV(*)', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ImageInput(),
              const SizedBox(height: 20),
              const Text('Transcript(*)', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ImageInput(),
              const SizedBox(height: 60),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      'Continue',
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
    );
  }
}
