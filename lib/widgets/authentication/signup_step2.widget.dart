import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/authentication/login.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/authentication/signup.provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

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
  bool isSending = false;

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showErrorToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void showSuccessToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userSignup = ref.watch(userSignupProvider);
    final user = ref.watch(userProvider);
    var ColorApp = ref.watch(colorProvider);

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
      backgroundColor: ColorApp.colorBackgroundColor,
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        ref.read(optionsProvider.notifier).setWidgetOption('SignupStep1', user.role!);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30,
                        color: ColorApp.colorTitle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please fill the below details',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorApp.colorText,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      controller: fullnameController,
                      onChanged: (data) {
                        if (fullnameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 17,
                        color: ColorApp.colorText,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Fullname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 15,
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      controller: emailController,
                      onChanged: (data) {
                        if (fullnameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 17,
                        color: ColorApp.colorText,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 15,
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      onChanged: (data) {
                        if (fullnameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 17,
                        color: ColorApp.colorText,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password (8 or more characters)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 15,
                        ),
                        prefixIcon: const Icon(Icons.key),
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
                      Text(
                        'Yes, I understand and agree to StudentHub',
                        style: TextStyle(fontSize: 16, color: ColorApp.colorText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: enable && isConfirm && !isSending
                          ? () async {
                              setState(() {
                                isSending = true;
                              });

                              final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/auth/sign-up');
                              final response = await http.post(url,
                                  headers: {'Content-Type': 'application/json'},
                                  body: json.encode(
                                    {"fullname": fullnameController.text, "email": emailController.text, "password": passwordController.text, "role": userSignup.role},
                                  ));

                              setState(() {
                                isSending = false;
                              });

                              if (json.decode(response.body).containsKey('errorDetails')) {
                                if (json.decode(response.body)['errorDetails'] is String) {
                                  showErrorToast('Error', json.decode(response.body)['errorDetails']);
                                } else {
                                  showErrorToast('Error', json.decode(response.body)['errorDetails'][0]);
                                }
                              } else {
                                // print(json.decode(response.body));
                                ref.read(userLoginProvider.notifier).setRole('${userSignup.role}');

                                showSuccessToast('Success', 'Create successfully, please check your email to verify account');
                                Timer(const Duration(seconds: 3), () {
                                  ref.read(optionsProvider.notifier).setWidgetOption('Login', user.role!);
                                });
                              }

                              // print(json.decode(response.body));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: ColorApp.colorEnableButton,
                        disabledBackgroundColor: ColorApp.colorButton,
                      ),
                      child: isSending
                          ? const SizedBox(
                              height: 17,
                              width: 17,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
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
                    mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                    children: [
                      Text(
                        'Looking for a project?',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorApp.colorText,
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
                            style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
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
