import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/profiles.provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:studenthub/providers/language/language.provider.dart';

import 'package:toastification/toastification.dart';

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

class ViewProfileWidget extends ConsumerWidget {
  const ViewProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final textCompany = TextEditingController();
    final textWebsite = TextEditingController();
    final textDescription = TextEditingController();
    final company = ref.watch(companyProvider);
    final user = ref.watch(userProvider);
    var Language = ref.watch(LanguageProvider);
    textCompany.text = company.companyName!;
    textWebsite.text = company.website!;
    textDescription.text = company.description!;

    final numOfPeople = company.size == 0
        ? Language.People_1
        : company.size == 1
            ? Language.People_2
            : company.size == 2
                ? Language.People_3
                : company.size == 3
                    ? Language.People_4
                    : Language.People_5;

    var selectedEmployee = ref.watch(selectedEmployeeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Language.CompanyProfile,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  Language.CompanyDes,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Language.Companyname,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 60,
                  child: TextField(
                    // maxLines: 1,
                    controller: textCompany,
                    style: const TextStyle(
                      fontSize: 16,
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
                ////////////////
                const SizedBox(height: 5),
                Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Language.Web,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: textWebsite,
                    // maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
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
                const SizedBox(height: 5),
                Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Language.Description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: textDescription,
                    maxLines: 4,
                    style: const TextStyle(
                      fontSize: 16,
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
                const SizedBox(height: 25),
                Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Language.PeopleCompany,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///////////////
                const SizedBox(height: 10),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: numOfPeople,
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {
                          ref.read(selectedEmployeeProvider.notifier).selectEmployee(value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: SizedBox(
                        height: 46,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Text(
                            Language.cancel,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () async {
                          final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/company/${company.id}');

                          final response = await http.put(url,
                              headers: {
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${user.token}',
                              },
                              body: json.encode(
                                {
                                  // "fullname": textCompany.text,
                                  "companyName": textCompany.text,
                                  "size": selectedEmployee,
                                  "website": textWebsite.text,
                                  "description": textDescription.text
                                },
                              ));

                          if (json.decode(response.body).containsKey('errorDetails')) {
                            if (json.decode(response.body)['errorDetails'] is String) {
                              showErrorToast('Error', json.decode(response.body)['errorDetails']);
                            } else {
                              showErrorToast('Error', json.decode(response.body)['errorDetails'][0]);
                            }
                          } else {
                            showSuccessToast('Success', 'Edit successfully');
                            ref.read(companyProvider.notifier).setCompanyData(
                                // json.decode(response.body)["result"]["id"],
                                // json.decode(response.body)["result"]
                                //     ["companyName"],
                                // json.decode(response.body)["result"]
                                //     ["website"],
                                // json.decode(response.body)["result"]
                                //     ["description"],
                                // json.decode(response.body)["result"]["size"],
                                company.id!,
                                textCompany.text,
                                textWebsite.text,
                                textDescription.text,
                                company.email!,
                                selectedEmployee);
                          }
                          Timer(const Duration(seconds: 3), () {
                            ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: Text(
                          Language.edit,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
