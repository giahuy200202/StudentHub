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

  bool isRememberPassword = false;
  bool isDisplayPassword = false;

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

    Icon iconRememberPassword = isRememberPassword
        ? const Icon(
            Icons.check_box,
            size: 25,
            color: Color.fromARGB(255, 121, 123, 125),
          )
        : const Icon(
            Icons.check_box_outline_blank,
            size: 25,
            color: Color.fromARGB(255, 151, 153, 155),
          );

    // print(user.name);
    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Let\'s Get Started!',
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
                      'Please fill the below details to Sign In your account',
                      style: TextStyle(
                        fontSize: 15.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 70,
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
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 70,
                    child: TextField(
                      obscureText: isDisplayPassword ? false : true,
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
                        prefixIcon: const Icon(Icons.key, size: 25),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isDisplayPassword = !isDisplayPassword;
                            });
                          },
                          child: Transform.translate(
                            offset: const Offset(0, 4.5),
                            child: isDisplayPassword
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isRememberPassword = !isRememberPassword;
                                  });
                                },
                                child: iconRememberPassword,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
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
                                if (json.decode(responseLogin.body)['errorDetails'] == String) {
                                  showErrorToast('Error', json.decode(responseLogin.body)['errorDetails']);
                                } else {
                                  showErrorToast('Error', json.decode(responseLogin.body)['errorDetails'][0]);
                                }
                              } else {
                                if (json.decode(responseLogin.body)['result'].runtimeType == String) {
                                  showErrorToast('Warning', 'Please verify your email');
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

                                  print(responeAuthMeData);

                                  //Set student data
                                  if (responeAuthMeData["result"]["student"] != null) {
                                    print('--------------------aaaaaaaaaaaa----------------------');
                                    ref.read(studentProvider.notifier).setStudentData(
                                      responeAuthMeData["result"]["student"]["id"],
                                      '',
                                      '',
                                      0,
                                      [],
                                      [],
                                      [],
                                      [],
                                    );

                                    final urlGetStudent = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${responeAuthMeData["result"]["student"]["id"]}');

                                    final responseStudent = await http.get(
                                      urlGetStudent,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${json.decode(responseLogin.body)["result"]["token"]}',
                                      },
                                    );

                                    final responseStudentData = json.decode(responseStudent.body);

                                    print('----------------');
                                    print(responseStudent.body);
                                    print('----------------');

                                    if (responseStudentData['result'] != null) {
                                      List<int> getSkillsets = [];
                                      for (var item in responseStudentData["result"]["skillSets"]) {
                                        getSkillsets.add(item['id']);
                                      }
                                      ref.read(studentProvider.notifier).setStudentData(
                                            responeAuthMeData["result"]["student"]["id"],
                                            responseStudentData["result"]["fullname"],
                                            responseStudentData["result"]["email"],
                                            responseStudentData["result"]["techStack"]["id"],
                                            getSkillsets,
                                            responseStudentData["result"]["educations"],
                                            responseStudentData["result"]["experiences"],
                                            responseStudentData["result"]["languages"],
                                          );
                                    }
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
                                  }

                                  Timer(const Duration(seconds: 3), () {
                                    ref.read(optionsProvider.notifier).setWidgetOption(
                                          userLoginRole == '0' ? 'ProfileInputStudent' : (responeAuthMeData["result"]["company"] == null ? 'ProfileInput' : 'Dashboard'),
                                          userLoginRole,
                                        );
                                  });
                                }
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
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Or continue with',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/google.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: const Icon(
                          Icons.apple,
                          size: 65,
                        ),
                      ),
                      const SizedBox(width: 25),
                      const Icon(
                        Icons.facebook_rounded,
                        size: 55,
                      ),
                    ],
                  ),
                  const SizedBox(height: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                    children: [
                      const Text(
                        'Don\'t have an account?',
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
                          ref.read(optionsProvider.notifier).setWidgetOption(
                                'SignupStep1',
                                user.role!,
                              );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 0.2,
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.blue,
                            width: 1.3,
                          ))),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
