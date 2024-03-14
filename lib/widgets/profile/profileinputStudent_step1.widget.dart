import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class ProfileIStudentWidget extends ConsumerStatefulWidget {
  const ProfileIStudentWidget({super.key});

  @override
  ConsumerState<ProfileIStudentWidget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget extends ConsumerState<ProfileIStudentWidget> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                'Tell us about your self and you will be your way connect with real-world project',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Techstack',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              DropdownMenu<String>(
                width: 360,
                initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Skillset',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              MultiSelectBottomSheet(
                items: selectCountryItem, // required for Item list
                width: 360,
                bottomSheetHeight:
                    500 * 0.7, // required for min/max height of bottomSheet
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Languages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'English: Native or Bilingual',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                    iconSize: 25,
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Le Hong Phong High School',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2008-2010',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.restore_from_trash,
                        color: Colors.black,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ho Chi Minh University of Sciences',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2010-2014',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.restore_from_trash,
                        color: Colors.black,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
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
