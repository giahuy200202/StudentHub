import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet_model.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// List<MultiSelectBottomSheetModel> selectCountryItem = [
//   MultiSelectBottomSheetModel(
//       id: 0, name: "IOS Development", isSelected: false),
//   MultiSelectBottomSheetModel(id: 1, name: "C", isSelected: false),
//   MultiSelectBottomSheetModel(id: 2, name: "Java", isSelected: false),
//   MultiSelectBottomSheetModel(id: 3, name: "Kubernetes", isSelected: false),
//   MultiSelectBottomSheetModel(id: 4, name: "PostgreSQL", isSelected: false),
//   MultiSelectBottomSheetModel(id: 5, name: "Android", isSelected: false),
//   MultiSelectBottomSheetModel(id: 7, name: "Node.js", isSelected: false),
//   MultiSelectBottomSheetModel(id: 8, name: "React Native", isSelected: false),
// ];
TextEditingController controller = TextEditingController();

class ProfileIStudentWidget extends ConsumerStatefulWidget {
  const ProfileIStudentWidget({super.key});

  @override
  ConsumerState<ProfileIStudentWidget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget extends ConsumerState<ProfileIStudentWidget> {
  List<String> techStackName = [];
  // late Future<List<MultiSelectBottomSheetModel>> selectSkillSetItem;
  List<MultiSelectBottomSheetModel> selectSkillSetItem = [];
  String dropdownValue = 'Fullstack Engineer';

  void getTechStack(String token) async {
    final url = Uri.parse(
        'http://${dotenv.env['IP_ADDRESS']}/api/techstack/getAllTechStack');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    var techStackData = [...json.decode(response.body)['result']];

    for (var item in techStackData) {
      techStackName.add(item['name']);
    }
    setState(() {
      dropdownValue = techStackName[2];
    });
  }

  void getSkillSet(String token) async {
    final url = Uri.parse(
        'http://${dotenv.env['IP_ADDRESS']}/api/skillset/getAllSkillSet');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    var skillSetData = [...json.decode(response.body)['result']];

    final List<MultiSelectBottomSheetModel> temp = [];
    for (var item in skillSetData) {
      temp.add(MultiSelectBottomSheetModel(
          id: item['id'], name: item['name'], isSelected: false));
    }

    setState(() {
      selectSkillSetItem = temp;
    });

    // print(selectSkillSetItem);
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    getTechStack(user.token!);
    getSkillSet(user.token!);
    // dropdownValue = techStackName[0];
    // 42
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    print(selectSkillSetItem);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: selectSkillSetItem.isEmpty || techStackName.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 350),
                    Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 13.5),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          )),
                      value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: techStackName
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Skillset',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // FutureBuilder<List<MultiSelectBottomSheetModel>>(
                    //     future: selectSkillSetItem,
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<List<MultiSelectBottomSheetModel>>
                    //             snapshot) {
                    //       return MultiSelectBottomSheet(
                    //         items: snapshot.data!, // required for Item list
                    //         width: 370,
                    //         bottomSheetHeight: 500 *
                    //             0.7, // required for min/max height of bottomSheet
                    //         hint: "Select Skillset",
                    //         controller: controller,
                    //         searchTextFieldWidth: 300 * 0.96,
                    //         searchIcon: const Icon(
                    //             // required for searchIcon
                    //             Icons.search,
                    //             color: Colors.black,
                    //             size: 22),
                    //         selectTextStyle:
                    //             const TextStyle(color: Colors.white, fontSize: 17),
                    //         unSelectTextStyle:
                    //             const TextStyle(color: Colors.black, fontSize: 17),
                    //       );
                    //     }),
                    MultiSelectBottomSheet(
                      items: selectSkillSetItem, // required for Item list
                      width: 370,
                      bottomSheetHeight: 500 *
                          0.7, // required for min/max height of bottomSheet
                      hint: "Select Skillset",
                      controller: controller,
                      searchTextFieldWidth: 300 * 0.96,
                      searchIcon: const Icon(
                          // required for searchIcon
                          Icons.search,
                          color: Colors.black,
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
                    SizedBox(
                      height: 60,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'English: Native or Bilingual',
                                      style: TextStyle(fontSize: 16),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Education',
                          style: TextStyle(
                            fontSize: 16,
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
                    SizedBox(
                      height: 165,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Le Hong Phong High School',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '2008-2010',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 94, 94, 94),
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
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Le Hong Phong High School',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '2008-2010',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 94, 94, 94),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 46,
                        width: 130,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(optionsProvider.notifier).setWidgetOption(
                                'ProfileInputStudentStep2', user.role!);
                            print(controller.text);
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
