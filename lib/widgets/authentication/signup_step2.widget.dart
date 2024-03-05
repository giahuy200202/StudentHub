import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';

class SignupStep2 extends ConsumerStatefulWidget {
  const SignupStep2({super.key});

  @override
  ConsumerState<SignupStep2> createState() {
    return _SignupStep2State();
  }
}

class _SignupStep2State extends ConsumerState<SignupStep2> {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isConfirm = false;
  bool enable = false;

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final tasks = ref.watch(tasksProvider);

    Icon iconCheckedConfirm = isConfirm
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
                    'Sign up as Company',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      controller: fullnameController,
                      onChanged: (data) {
                        if (fullnameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Fullname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      controller: emailController,
                      onChanged: (data) {
                        if (fullnameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Work email address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      controller: passwordController,
                      onChanged: (data) {
                        if (fullnameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password (8 or more characters)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isConfirm = !isConfirm;
                          });
                        },
                        child: iconCheckedConfirm,
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        'Yes, I understand and agree to StudentHub',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: enable && isConfirm ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Create my account',
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
                        'Looking for a project?',
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
                        onPressed: () {},
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
                            "Apply as student",
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
