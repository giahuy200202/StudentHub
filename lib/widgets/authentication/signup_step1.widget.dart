import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/authentication/signup.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';

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
    var ColorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
    Icon iconCheckedCompany = isCompany
        ? Icon(
            Icons.check_circle,
            size: 30,
            color: ColorApp.colorIcon,
          )
        : const Icon(
            Icons.circle_outlined,
            size: 30,
            color: Color.fromARGB(255, 151, 153, 155),
          );

    Icon iconCheckedStudent = isStudent
        ? Icon(
            Icons.check_circle,
            size: 30,
            color: ColorApp.colorIcon,
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
                      Language.Register,
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
                      Language.DesRegister,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorApp.colorText,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorApp.colorBackgroundColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                              Icon(
                                Icons.house,
                                size: 30,
                                color: ColorApp.colorTitle,
                              ),
                              const SizedBox(width: 8),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 260,
                                  child: Text(
                                    Language.Company,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorApp.colorTitle,
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
                                  ref.read(userSignupProvider.notifier).setRole(1);
                                },
                                child: iconCheckedCompany,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 340,
                              child: Text(
                                Language.RegisterCompany,
                                style: TextStyle(
                                  color: ColorApp.colorText,
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
                    decoration: BoxDecoration(
                      color: ColorApp.colorBackgroundColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                              Icon(
                                Icons.person,
                                size: 30,
                                color: ColorApp.colorTitle,
                              ),
                              const SizedBox(width: 8),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 260,
                                  child: Text(
                                    Language.Student,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorApp.colorTitle,
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
                                  ref.read(userSignupProvider.notifier).setRole(0);
                                },
                                child: iconCheckedStudent,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 340,
                              child: Text(
                                Language.RegisterStudent,
                                style: TextStyle(
                                  color: ColorApp.colorText,
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
                  const SizedBox(height: 45),
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: !isCompany && !isStudent
                          ? null
                          : () {
                              ref.read(optionsProvider.notifier).setWidgetOption(
                                    'SignupStep2',
                                    user.role!,
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: ColorApp.colorEnableButton,
                        disabledBackgroundColor: ColorApp.colorButton,
                      ),
                      child: Text(
                        Language.CreateAccount,
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
                        Language.TextRegister,
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
                        onPressed: () {
                          ref.read(optionsProvider.notifier).setWidgetOption('Login', user.role!);
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
                          child: Text(
                            Language.Login,
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
