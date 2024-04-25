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
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'dart:convert';

import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class ForgotPasswordWidget extends ConsumerStatefulWidget {
  const ForgotPasswordWidget({super.key});

  @override
  ConsumerState<ForgotPasswordWidget> createState() {
    return _ForgotPasswordWidgetState();
  }
}

class _ForgotPasswordWidgetState extends ConsumerState<ForgotPasswordWidget> {
  var emailController = TextEditingController();
  bool isSending = false;
  bool enable = false;

  @override
  void dispose() {
    emailController.dispose();
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
    var colorApp = ref.watch(colorProvider);

    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
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
                        ref.read(optionsProvider.notifier).setWidgetOption('Login', user.role!);
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
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 30,
                        color: colorApp.colorTitle,
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
                        color: colorApp.colorText,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      controller: emailController,
                      onChanged: (data) {
                        if (emailController.text.isEmpty) {
                          enable = false;
                        } else {
                          enable = true;
                        }
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 17,
                        color: colorApp.colorText,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        labelStyle: TextStyle(color: colorApp.colorText),
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
                        prefixIcon: const Icon(Icons.mail),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: enable && !isSending
                          ? () async {
                              setState(() {
                                isSending = true;
                              });

                              final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/user/forgotPassword');
                              final responseForgotPassword = await http.post(url,
                                  headers: {'Content-Type': 'application/json'},
                                  body: json.encode(
                                    {
                                      "email": emailController.text,
                                    },
                                  ));

                              final responseForgotPasswordData = json.decode(responseForgotPassword.body);

                              print('----responseForgotPasswordData----');
                              print(responseForgotPasswordData);

                              setState(() {
                                isSending = false;
                              });

                              if (json.decode(responseForgotPassword.body).containsKey('errorDetails')) {
                                if (json.decode(responseForgotPassword.body)['errorDetails'] is String) {
                                  showErrorToast('Error', json.decode(responseForgotPassword.body)['errorDetails']);
                                } else {
                                  showErrorToast('Error', json.decode(responseForgotPassword.body)['errorDetails'][0]);
                                }
                              } else {
                                // print(json.decode(response.body));

                                showSuccessToast('Success', responseForgotPasswordData['result']['message']);

                                Timer(const Duration(seconds: 3), () {
                                  ref.read(userProvider.notifier).setUserData(0, '', '');
                                  ref.read(companyProvider.notifier).setCompanyData(0, '', '', '', '', 0);
                                  ref.read(studentProvider.notifier).setStudentData(0, '', '', 0, [], [], [], []);
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
                        backgroundColor: colorApp.colorEnableButton,
                        disabledBackgroundColor: colorApp.colorButton,
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
                              'Reset password',
                              style: TextStyle(
                                fontSize: 16,
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
                          color: colorApp.colorText,
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
