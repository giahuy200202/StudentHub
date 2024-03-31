import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/profiles.provider.dart';
import 'package:http/http.dart' as http;

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

class ProfileInputWidget extends ConsumerStatefulWidget {
  const ProfileInputWidget({super.key});

  @override
  ConsumerState<ProfileInputWidget> createState() {
    return _ProfileInputWidgetState();
  }
}

class _ProfileInputWidgetState extends ConsumerState<ProfileInputWidget> {
  var enable = false;
  var isClick = false;
  final textCompany = TextEditingController();
  final textWebsite = TextEditingController();
  final textDescription = TextEditingController();

  @override
  void dispose() {
    textCompany.dispose();
    textWebsite.dispose();
    textDescription.dispose();
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
    var selectedEmployee = ref.watch(selectedEmployeeProvider);
    ref.watch(TextCompanyEmployeeProvider);
    ref.watch(TextWebsiteEmpoyleeProvider);
    ref.watch(TextDescriptionEmpoyleeProvider);
    final user = ref.watch(userProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Welcome to Student Hub',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tell us about your company and you will be on your way connect with high-skilled students',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'How many people in company?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              ////////////////////////////////////////
              const SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: 'It\'s just me',
                      value: 1,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        isClick = true;
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: '2-9 employees',
                      value: 2,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        isClick = true;
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: '10-99 employees',
                      value: 3,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        isClick = true;
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: "100-1000 employees",
                      value: 4,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        isClick = true;
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: 'More than 1000 employees',
                      value: 5,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        isClick = true;
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                ],
              ),

              //////////////////////////////////////
              const SizedBox(height: 15),
              const Text(
                'Company name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: textCompany,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty ||
                        textWebsite.text.isEmpty ||
                        textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                      ref
                          .read(TextCompanyEmployeeProvider.notifier)
                          .TextCompanye(data);
                    }
                    setState(() {});
                  },
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              //////
              const Text(
                'Website',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: textWebsite,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty ||
                        textWebsite.text.isEmpty ||
                        textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                      ref
                          .read(TextWebsiteEmpoyleeProvider.notifier)
                          .TextWebsitee(data);
                    }
                    setState(() {});
                  },
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              //////
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: TextField(
                  maxLines: 4,
                  controller: textDescription,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty ||
                        textWebsite.text.isEmpty ||
                        textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      ref
                          .read(TextDescriptionEmpoyleeProvider.notifier)
                          .TextDescriptione(data);
                      enable = true;
                    }
                    setState(() {});
                  },
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),

              ///
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: enable && isClick
                        ? () async {
                            final url = Uri.parse(
                                'http://${dotenv.env['IP_ADDRESS']}/api/profile/company');

                            final response = await http.post(url,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer ${user.token}',
                                },
                                body: json.encode(
                                  {
                                    "fullname": textCompany.text,
                                    "companyName": textCompany.text,
                                    "size": selectedEmployee,
                                    "website": textWebsite.text,
                                    "description": textDescription.text
                                  },
                                ));

                            if (json
                                .decode(response.body)
                                .containsKey('errorDetails')) {
                              if (json.decode(response.body)['errorDetails']
                                  is String) {
                                showErrorToast('Error',
                                    json.decode(response.body)['errorDetails']);
                              } else {
                                showErrorToast(
                                    'Error',
                                    json.decode(response.body)['errorDetails']
                                        [0]);
                              }
                            } else {
                              showSuccessToast(
                                  'Success', 'Create successfully');
                              ref.read(companyProvider.notifier).setCompanyData(
                                    json.decode(response.body)["result"]["id"],
                                    json.decode(response.body)["result"]
                                        ["companyName"],
                                    json.decode(response.body)["result"]
                                        ["website"],
                                    json.decode(response.body)["result"]
                                        ["description"],
                                    json.decode(response.body)["result"]
                                        ["size"],
                                  );

                              Timer(const Duration(seconds: 3), () {
                                ref
                                    .read(optionsProvider.notifier)
                                    .setWidgetOption('Welcome', user.role!);
                              });
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.black),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              ///
            ],
          ),
        ),
      ),
    );
  }
}
