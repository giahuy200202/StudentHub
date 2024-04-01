import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:studenthub/helpers/alert_toast.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/authentication/login.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/providers/profile/company.provider.dart';
import 'dart:convert';

import 'package:studenthub/providers/profile/student.provider.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() {
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool enable = false;
  bool isSending = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showErrorToast(title, description) {
    MotionToast(
      icon: Icons.clear,
      primaryColor: Colors.red,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontSize: 16,
          // overflow: TextOverflow.ellipsis,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      width: 500,
      height: 80,
    ).show(context);
  }

  void showSuccessToast(title, description) {
    MotionToast(
      icon: Icons.check,
      primaryColor: Colors.green,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      width: 500,
      height: 80,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final userLoginRole = ref.watch(userLoginProvider);
    final company = ref.watch(companyProvider);

    // print(user.name);
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
                    'Login with StudentHub',
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
                      controller: usernameController,
                      onChanged: (data) {
                        if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
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
                        labelText: 'Username or email',
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
                        if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
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
                        labelText: 'Password',
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
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 53,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: enable && !isSending
                          ? () async {
                              setState(() {
                                isSending = true;
                              });
                              final urlLogin = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/auth/sign-in');
                              final responseLogin = await http.post(urlLogin,
                                  headers: {'Content-Type': 'application/json'},
                                  body: json.encode(
                                    {"email": usernameController.text, "password": passwordController.text},
                                  ));

                              if (json.decode(responseLogin.body).containsKey('errorDetails')) {
                                if (json.decode(responseLogin.body)['errorDetails'] is String) {
                                  showErrorToast('Error', json.decode(responseLogin.body)['errorDetails']);
                                } else {
                                  showErrorToast('Error', json.decode(responseLogin.body)['errorDetails'][0]);
                                }
                              } else {
                                final urlAuthMe = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/auth/me');
                                final responseAuthMe = await http.get(
                                  urlAuthMe,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${json.decode(responseLogin.body)["result"]["token"]}',
                                  },
                                );
                                final responeAuthMeData = json.decode(responseAuthMe.body);

                                //Set authentication data
                                ref.read(userProvider.notifier).setUserData(
                                      responeAuthMeData["result"]["id"],
                                      userLoginRole,
                                      json.decode(responseLogin.body)["result"]["token"],
                                    );

                                showSuccessToast('Success', 'Login successfully');

                                //Set student data
                                if (responeAuthMeData["result"]["student"] != null) {
                                  ref.read(studentProvider.notifier).setStudentData(
                                    responeAuthMeData["result"]["student"]["id"],
                                    responeAuthMeData["result"]["student"]["fullname"],
                                    '',
                                    0,
                                    [],
                                    [],
                                    [],
                                    [],
                                  );

                                  final urlLogin = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${responeAuthMeData["result"]["student"]["id"]}');

                                  final responseStudent = await http.get(
                                    urlLogin,
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer ${json.decode(responseLogin.body)["result"]["token"]}',
                                    },
                                  );

                                  final responseStudentData = json.decode(responseStudent.body);

                                  if (responseStudentData['result'] != null) {
                                    ref.read(studentProvider.notifier).setStudentData(
                                          responeAuthMeData["result"]["student"]["id"],
                                          responeAuthMeData["result"]["student"]["fullname"],
                                          responseStudentData["result"]["email"],
                                          responseStudentData["result"]["techStack"]["id"],
                                          responseStudentData["result"]["skillSets"],
                                          responseStudentData["result"]["educations"],
                                          responseStudentData["result"]["experiences"],
                                          responseStudentData["result"]["languages"],
                                        );
                                  }
                                  print('-----student------');
                                  print(responseStudentData['result']);
                                  print('-----------');

                                  Timer(const Duration(seconds: 3), () {
                                    ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                                  });
                                }

                                // //Set company data
                                if (responeAuthMeData["result"]["company"] != null) {
                                  ref.read(companyProvider.notifier).setCompanyData(
                                        responeAuthMeData["result"]["company"]["id"],
                                        responeAuthMeData["result"]["company"]["companyName"],
                                        '',
                                        responeAuthMeData["result"]["company"]["description"],
                                        '',
                                        0,
                                      );

                                  final urlLogin = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/company/${responeAuthMeData["result"]["company"]["id"]}');

                                  final responseCompany = await http.get(
                                    urlLogin,
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer ${json.decode(responseLogin.body)["result"]["token"]}',
                                    },
                                  );

                                  final responseCompanyData = json.decode(responseCompany.body);

                                  if (responseCompanyData['result'] != null) {
                                    ref.read(companyProvider.notifier).setCompanyData(
                                          responeAuthMeData["result"]["company"]["id"],
                                          responeAuthMeData["result"]["company"]["companyName"],
                                          responseCompanyData["result"]["website"],
                                          responeAuthMeData["result"]["company"]["description"],
                                          responseCompanyData["result"]["email"],
                                          responseCompanyData["result"]["size"],
                                        );
                                  }

                                  Timer(const Duration(seconds: 3), () {
                                    ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', userLoginRole);
                                  });
                                }

                                Timer(const Duration(seconds: 3), () {
                                  ref.read(optionsProvider.notifier).setWidgetOption(userLoginRole == '0' ? 'ProfileInputStudent' : (responeAuthMeData["result"]["company"] == null ? 'ProfileInput' : 'Dashboard'), userLoginRole);
                                });
                              }
                              setState(() {
                                isSending = false;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.black,
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
                              'Sign in',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 290),
                  const Text(
                    '_______Don\'t have an Student Hub account?_______',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 46,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(optionsProvider.notifier).setWidgetOption('SignupStep1', user.role!);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Colors.black)),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Sign up',
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
            ),
          )),
    );
  }
}
