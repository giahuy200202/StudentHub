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
import 'package:studenthub/providers/switch_account.provider.dart';
import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

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
    final user = ref.watch(userProvider);
    final userLoginRole = ref.watch(userLoginProvider);
    final company = ref.watch(companyProvider);
    var ColorApp = ref.watch(colorProvider);
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
      backgroundColor: ColorApp.colorBackgroundColor,
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        ref.read(optionsProvider.notifier).setWidgetOption('', user.role!);
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
                      'Let\'s Get Started!',
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
                      'Please fill the below details to Sign In your account',
                      style: TextStyle(
                        fontSize: 15.5,
                        color: ColorApp.colorText,
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
                      style: TextStyle(fontSize: 17, color: ColorApp.colorText),
                      decoration: InputDecoration(
                        labelText: 'Username or email',
                        labelStyle: TextStyle(
                          color: ColorApp.colorText,
                        ),
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
                      style: TextStyle(fontSize: 17, color: ColorApp.colorText),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: ColorApp.colorText,
                        ),
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
                              Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: ColorApp.colorText,
                                  // fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          ref.read(optionsProvider.notifier).setWidgetOption(
                                'ForgotPassword',
                                userLoginRole,
                              );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorApp.colorText,
                            fontWeight: FontWeight.w700,
                          ),
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
                                if (json.decode(responseLogin.body)['errorDetails'].runtimeType == String) {
                                  showErrorToast('Error', json.decode(responseLogin.body)['errorDetails']);
                                } else {
                                  showErrorToast('Error', json.decode(responseLogin.body)['errorDetails'][0]);
                                }
                              } else {
                                if (json.decode(responseLogin.body)['result'].runtimeType == String) {
                                  showErrorToast('Warning', json.decode(responseLogin.body)['result']);
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

                                  print('---responeAuthMeData---');
                                  print(responeAuthMeData);

                                  print('-----user.token----');
                                  print(json.decode(responseLogin.body)["result"]["token"]);

                                  //Set authentication data
                                  ref.read(userProvider.notifier).setUserData(
                                        responeAuthMeData["result"]["id"],
                                        userLoginRole,
                                        json.decode(responseLogin.body)["result"]["token"],
                                      );
                                  ref.read(switchAccountProvider.notifier).setSwitchAccount(
                                        userLoginRole,
                                      );

                                  showSuccessToast('Success', 'Login successfully');

                                  print('------------------responeAuthMeData["result"]["student"]');
                                  print(responeAuthMeData["result"]["student"]);
                                  //Set student data
                                  if (responeAuthMeData["result"]["student"] != null) {
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

                                    print('---responseStudentData---');
                                    print(responseStudentData);

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

                                    //set resume
                                    final urlResume = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${responeAuthMeData["result"]["student"]["id"]}/resume');
                                    final responseResumeGet = await http.get(
                                      urlResume,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${json.decode(responseLogin.body)["result"]["token"]}',
                                      },
                                    );

                                    var resumeData = json.decode(responseResumeGet.body)['result'];

                                    print('---resumeData---');
                                    print(resumeData);
                                    ref.read(studentProvider.notifier).setStudentResume(resumeData ?? '');

                                    //set transcript
                                    final urlTranscript = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${responeAuthMeData["result"]["student"]["id"]}/transcript');
                                    final responseTranscriptGet = await http.get(
                                      urlTranscript,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${json.decode(responseLogin.body)["result"]["token"]}',
                                      },
                                    );

                                    var transcriptData = json.decode(responseTranscriptGet.body)['result'];
                                    print('---transcriptData---');
                                    print(transcriptData);
                                    ref.read(studentProvider.notifier).setStudentTranscript(transcriptData ?? '');
                                  } else {
                                    print('-------------------');
                                    ref.read(studentProvider.notifier).setStudentData(
                                      0,
                                      '',
                                      '',
                                      0,
                                      [],
                                      [],
                                      [],
                                      [],
                                    );
                                    ref.read(studentProvider.notifier).setStudentResume('');
                                    ref.read(studentProvider.notifier).setStudentTranscript('');
                                  }

                                  // Set company data
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

                                    print('---responseCompanyData---');
                                    print(responseCompanyData);

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
                                  } else {
                                    ref.read(companyProvider.notifier).setCompanyData(
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          0,
                                        );
                                  }

                                  Timer(const Duration(seconds: 3), () {
                                    ref.read(optionsProvider.notifier).setWidgetOption(
                                          userLoginRole == '0' ? (responeAuthMeData["result"]["company"] == null ? 'ProfileInputStudent' : 'Projects') : (responeAuthMeData["result"]["company"] == null ? 'ProfileInput' : 'Dashboard'),
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
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorApp.colorSignIn,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(color: ColorApp.colorDivider),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Or continue with',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorApp.colorText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(color: ColorApp.colorDivider),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/google.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: Icon(
                          Icons.apple,
                          size: 65,
                          color: ColorApp.colorIcon,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/facebook.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorApp.colorText as Color,
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
