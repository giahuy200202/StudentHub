import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet_model.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet.dart';

const List<String> list = <String>[
  'Fullstack Engineer',
  'Frontend Engineer',
  'Backend Engineer',
  'Business Analyst',
  'Product Manage'
];

List<MultiSelectBottomSheetModel> selectCountryItem = [
  MultiSelectBottomSheetModel(
      id: 0, name: "IOS Development", isSelected: false),
  MultiSelectBottomSheetModel(id: 1, name: "C", isSelected: false),
  MultiSelectBottomSheetModel(id: 2, name: "Java", isSelected: false),
  MultiSelectBottomSheetModel(id: 3, name: "Kubernetes", isSelected: false),
  MultiSelectBottomSheetModel(id: 4, name: "PostgreSQL", isSelected: false),
  MultiSelectBottomSheetModel(id: 5, name: "Android", isSelected: false),
  MultiSelectBottomSheetModel(id: 7, name: "Node.js", isSelected: false),
  MultiSelectBottomSheetModel(id: 8, name: "React Native", isSelected: false),
];
TextEditingController controller = TextEditingController();

class ProfileIStudentStep2Widget extends ConsumerStatefulWidget {
  const ProfileIStudentStep2Widget({super.key});

  @override
  ConsumerState<ProfileIStudentStep2Widget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget extends ConsumerState<ProfileIStudentStep2Widget> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
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
                  'Experiences',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Tell us about your self and you will be your way connect with real-world project',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Intelligent Taxi Dispatching system',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '9/2020 - 12/2020, 4 months',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 94, 94, 94),
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.edit_calendar,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'It is the developer of a super-app for ride-halling, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Skillset',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MultiSelectBottomSheet(
                        items: selectCountryItem, // required for Item list
                        width: MediaQuery.of(context).size.width,
                        bottomSheetHeight: 500 *
                            0.7, // required for min/max height of bottomSheet
                        hint: "Select Skillset",
                        controller: controller,
                        searchTextFieldWidth: 300 * 0.96,
                        searchIcon: const Icon(
                            // required for searchIcon
                            Icons.search,
                            color: Colors.black87,
                            size: 22),
                        selectTextStyle:
                            const TextStyle(color: Colors.white, fontSize: 17),
                        unSelectTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // const Divider(
              //   height: 10,
              //   thickness: 1,
              //   endIndent: 0,
              //   color: Colors.grey,
              // ),
              const SizedBox(height: 180),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(optionsProvider.notifier).setWidgetOption(
                          'ProfileInputStudentStep3', user.role!);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
