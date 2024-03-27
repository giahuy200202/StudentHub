import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void handleLogin() async {
    setState(() {
      isSending = true;
    });
    final url =
        Uri.parse('http://${dotenv.env['IP_ADDRESS']}:4400/auth/sign-in');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "email": usernameController.text,
            "password": passwordController.text
          },
        ));

    // final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}:4400/auth/me');
    // final response = await http.get(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization':
    //         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJnaWFodXkyMDAyMDJAZ21haWwuY29tIiwicm9sZXMiOlsiVVNFUiIsInN0dWRlbnQiXSwiaWF0IjoxNzExNTEwNjU0LCJleHAiOjE3MTI3MjAyNTR9.cgddUEweovamU80M4XOHvxgLp1Un1QVIYgmVQ7IP6BA',
    //   },
    // );

    setState(() {
      isSending = false;
    });
    print(json.decode(response.body));
    // print(json.decode(response.body)["result"]["token"]);
  }

  @override
  Widget build(BuildContext context) {
    // final tasks = ref.watch(tasksProvider);

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
                        if (usernameController.text.isEmpty ||
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
                        labelText: 'Username or email',
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
                        if (usernameController.text.isEmpty ||
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
                        labelText: 'Password',
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
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 53,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: enable || !isSending ? handleLogin : null,
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
                        ref
                            .read(optionsProvider.notifier)
                            .setWidgetOption('SignupStep1');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.black)),
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
