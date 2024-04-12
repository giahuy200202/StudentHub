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

class ChangePasswordWidget extends ConsumerStatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  ConsumerState<ChangePasswordWidget> createState() {
    return _ChangePasswordWidgetState();
  }
}

class _ChangePasswordWidgetState extends ConsumerState<ChangePasswordWidget> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  bool isSending = false;
  bool enable = false;
  bool isDisplayOldPassword = false;
  bool isDisplayNewPassword = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
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

    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please fill the below details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      obscureText: isDisplayOldPassword ? false : true,
                      controller: oldPasswordController,
                      onChanged: (data) {
                        if (oldPasswordController.text.isEmpty || newPasswordController.text.isEmpty) {
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
                        labelText: 'Enter your old password',
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
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isDisplayOldPassword = !isDisplayOldPassword;
                            });
                          },
                          child: Transform.translate(
                            offset: const Offset(0, 4.5),
                            child: isDisplayOldPassword
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 21,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    size: 21,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      obscureText: isDisplayNewPassword ? false : true,
                      controller: newPasswordController,
                      onChanged: (data) {
                        if (oldPasswordController.text.isEmpty || newPasswordController.text.isEmpty) {
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
                        labelText: 'Enter your new password',
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
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isDisplayNewPassword = !isDisplayNewPassword;
                            });
                          },
                          child: Transform.translate(
                            offset: const Offset(0, 4.5),
                            child: isDisplayNewPassword
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 21,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    size: 21,
                                  ),
                          ),
                        ),
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

                              final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/user/changePassword');
                              final responseChangePassword = await http.put(url,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${user.token}',
                                  },
                                  body: json.encode(
                                    {
                                      "oldPassword": oldPasswordController.text,
                                      "newPassword": newPasswordController.text,
                                    },
                                  ));

                              final responseChangePasswordData = json.decode(responseChangePassword.body);

                              print('----responseChangePasswordData----');
                              print(responseChangePasswordData);

                              setState(() {
                                isSending = false;
                              });

                              if (json.decode(responseChangePassword.body).containsKey('errorDetails')) {
                                if (json.decode(responseChangePassword.body)['errorDetails'] is String) {
                                  showErrorToast('Error', json.decode(responseChangePassword.body)['errorDetails']);
                                } else {
                                  showErrorToast('Error', json.decode(responseChangePassword.body)['errorDetails'][0]);
                                }
                              } else {
                                // print(json.decode(response.body));

                                showSuccessToast('Success', 'Change password successfully, please login again');

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
                              'Change password',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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
