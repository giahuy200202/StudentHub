import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/authentication/signup.provider.dart';

class SignupStep1 extends ConsumerStatefulWidget {
  const SignupStep1({super.key});

  @override
  ConsumerState<SignupStep1> createState() {
    return _SignupStep1State();
  }
}

class _SignupStep1State extends ConsumerState<SignupStep1> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  bool isCompany = false;
  bool isStudent = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    Icon iconCheckedCompany = isCompany
        ? const Icon(
            Icons.check_circle,
            size: 30,
            color: Color.fromARGB(255, 121, 123, 125),
          )
        : const Icon(
            Icons.circle_outlined,
            size: 30,
            color: Color.fromARGB(255, 151, 153, 155),
          );

    Icon iconCheckedStudent = isStudent
        ? const Icon(
            Icons.check_circle,
            size: 30,
            color: Color.fromARGB(255, 121, 123, 125),
          )
        : const Icon(
            Icons.circle_outlined,
            size: 30,
            color: Color.fromARGB(255, 151, 153, 155),
          );

    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Join as company or student',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 233, 236, 239),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.house,
                                size: 30,
                              ),
                              const SizedBox(width: 8),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 260,
                                  child: Text(
                                    'Company',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isCompany = true;
                                    isStudent = false;
                                  });
                                  ref
                                      .read(userSignupProvider.notifier)
                                      .setRole(1);
                                },
                                child: iconCheckedCompany,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 340,
                              child: Text(
                                'I am a company, find engineers for project',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 233, 236, 239),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 30,
                              ),
                              const SizedBox(width: 8),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 260,
                                  child: Text(
                                    'Student',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isCompany = false;
                                    isStudent = true;
                                  });
                                  ref
                                      .read(userSignupProvider.notifier)
                                      .setRole(0);
                                },
                                child: iconCheckedStudent,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 340,
                              child: Text(
                                'I am a student, research for project',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: !isCompany && !isStudent
                          ? null
                          : () {
                              ref
                                  .read(optionsProvider.notifier)
                                  .setWidgetOption('SignupStep2', user.role!);
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Column contents vertically,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          ref
                              .read(optionsProvider.notifier)
                              .setWidgetOption('Login', user.role!);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 0.5,
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.blue,
                            width: 1.3,
                          ))),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
