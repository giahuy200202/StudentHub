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
import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.textColor,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color? textColor;
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
            style: TextStyle(color: textColor, fontSize: 16),
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
    var selectedEmployee = ref.watch(selectedEmployeeProvider);
    ref.watch(TextCompanyEmployeeProvider);
    ref.watch(TextWebsiteEmpoyleeProvider);
    ref.watch(TextDescriptionEmpoyleeProvider);
    final user = ref.watch(userProvider);
    final company = ref.watch(companyProvider);
    var colorApp = ref.watch(colorProvider);

    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Company profile',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: colorApp.colorTitle,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Tell us about your company and you will be your way connect with real-world project',
                style: TextStyle(
                  fontSize: 16,
                  color: colorApp.colorText,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'How many people in company?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorApp.colorText,
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
                      textColor: colorApp.colorText,
                      onChanged: (value) {
                        isClick = true;
                        ref.read(selectedEmployeeProvider.notifier).selectEmployee(value!);
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
                      textColor: colorApp.colorText,
                      onChanged: (value) {
                        isClick = true;
                        ref.read(selectedEmployeeProvider.notifier).selectEmployee(value!);
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
                      textColor: colorApp.colorText,
                      onChanged: (value) {
                        isClick = true;
                        ref.read(selectedEmployeeProvider.notifier).selectEmployee(value!);
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
                      textColor: colorApp.colorText,
                      onChanged: (value) {
                        isClick = true;
                        ref.read(selectedEmployeeProvider.notifier).selectEmployee(value!);
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
                      textColor: colorApp.colorText,
                      onChanged: (value) {
                        isClick = true;
                        ref.read(selectedEmployeeProvider.notifier).selectEmployee(value!);
                      },
                    ),
                  ),
                ],
              ),

              //////////////////////////////////////
              const SizedBox(height: 15),
              Text(
                'Company name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorApp.colorTitle,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: textCompany,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty || textWebsite.text.isEmpty || textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                      ref.read(TextCompanyEmployeeProvider.notifier).TextCompanye(data);
                    }
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: 17,
                    color: colorApp.colorText,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              //////
              Text(
                'Website',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorApp.colorTitle,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: textWebsite,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty || textWebsite.text.isEmpty || textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                      ref.read(TextWebsiteEmpoyleeProvider.notifier).TextWebsitee(data);
                    }
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: 17,
                    color: colorApp.colorText,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.grey),
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
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorApp.colorTitle,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: TextField(
                  maxLines: 4,
                  controller: textDescription,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty || textWebsite.text.isEmpty || textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      ref.read(TextDescriptionEmpoyleeProvider.notifier).TextDescriptione(data);
                      enable = true;
                    }
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: 17,
                    color: colorApp.colorText,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.grey),
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
                            final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/company');

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
                                    "description": textDescription.text,
                                  },
                                ));

                            print('----response create company----');
                            print(json.decode(response.body));

                            if (json.decode(response.body).containsKey('errorDetails')) {
                              if (json.decode(response.body)['errorDetails'] is String) {
                                showErrorToast('Error', json.decode(response.body)['errorDetails']);
                              } else {
                                showErrorToast('Error', json.decode(response.body)['errorDetails'][0]);
                              }
                            } else {
                              showSuccessToast('Success', 'Create successfully');
                              print('----json.decode(response.body)["result"]["id"]----');
                              print(json.decode(response.body)["result"]["id"]);
                              print('----json.decode(response.body)["result"]["companyName"]----');
                              print(json.decode(response.body)["result"]["companyName"]);
                              print('----json.decode(response.body)["result"]["website"]----');
                              print(json.decode(response.body)["result"]["website"]);
                              print('----json.decode(response.body)["result"]["description"]----');
                              print(json.decode(response.body)["result"]["description"]);
                              print('----company.email----');
                              print(company.email!);
                              print('----json.decode(response.body)["result"]["size"]----');
                              print(json.decode(response.body)["result"]["size"]);
                              ref.read(companyProvider.notifier).setCompanyData(
                                    json.decode(response.body)["result"]["id"],
                                    json.decode(response.body)["result"]["companyName"],
                                    json.decode(response.body)["result"]["website"],
                                    json.decode(response.body)["result"]["description"],
                                    '',
                                    json.decode(response.body)["result"]["size"],
                                  );

                              Timer(const Duration(seconds: 3), () {
                                ref.read(optionsProvider.notifier).setWidgetOption('Welcome', user.role!);
                              });
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.grey),
                      ),
                      backgroundColor: colorApp.colorBlackWhite,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        color: colorApp.colorWhiteBlack,
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
