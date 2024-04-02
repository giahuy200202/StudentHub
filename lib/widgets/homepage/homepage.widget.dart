import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/authentication/login.provider.dart';
import 'package:studenthub/providers/options.provider.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class HomepageWidget extends ConsumerWidget {
  const HomepageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final tasks = ref.watch(tasksProvider);
    final user = ref.watch(userProvider);
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
                const SizedBox(height: 350),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 300,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Build your product with ',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        children: [
                          TextSpan(
                            text: 'high-skilled',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: ' student'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects. StudentHub is university market place to connect high-skilled student and company on a real-world project',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 70),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(userLoginProvider.notifier).setRole('1');

                      ref
                          .read(optionsProvider.notifier)
                          .setWidgetOption('Login', user.role!);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.grey),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Company',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(userLoginProvider.notifier).setRole('0');
                      ref
                          .read(optionsProvider.notifier)
                          .setWidgetOption('Login', user.role!);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.grey),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Student',
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
