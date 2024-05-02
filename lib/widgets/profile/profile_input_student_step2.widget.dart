import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/profile/student_input.provider.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet_model.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet_exp.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/language/language.provider.dart';

class ExperienceCreate {
  String title;
  String description;
  String startMonth;
  String endMonth;
  List<dynamic> skillSets;

  ExperienceCreate(
    this.title,
    this.description,
    this.startMonth,
    this.endMonth,
    this.skillSets,
  );

  ExperienceCreate.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'],
        description = json['description'],
        startMonth = json['startMonth'],
        endMonth = json['endMonth'],
        skillSets = json['skillSets'];

  Map<dynamic, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startMonth': startMonth,
      'endMonth': endMonth,
      'skillSets': skillSets,
    };
  }
}

class ExperienceFetch {
  int id;
  String title;
  String description;
  String startMonth;
  String endMonth;
  List<dynamic> skillSets;

  ExperienceFetch(
    this.id,
    this.title,
    this.description,
    this.startMonth,
    this.endMonth,
    this.skillSets,
  );

  ExperienceFetch.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        startMonth = json['startMonth'],
        endMonth = json['endMonth'],
        skillSets = json['skillSets'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startMonth': startMonth,
      'endMonth': endMonth,
      'skillSets': skillSets,
    };
  }
}

TextEditingController controller = TextEditingController();

class ProfileIStudentStep2Widget extends ConsumerStatefulWidget {
  const ProfileIStudentStep2Widget({super.key});

  @override
  ConsumerState<ProfileIStudentStep2Widget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget extends ConsumerState<ProfileIStudentStep2Widget> {
  List<MultiSelectBottomSheetModel> skillSetItems = [];

  List<List<MultiSelectBottomSheetModel>> skillSetItemsForCreate = [];
  List<List<MultiSelectBottomSheetModel>> defaultListAll = [];
  List<List<MultiSelectBottomSheetModel>> filterListAll = [];

  bool isGettingExp = false;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startMonthController = TextEditingController();
  final endMonthController = TextEditingController();

  final editTitleController = TextEditingController();
  final editDescriptionController = TextEditingController();
  final editStartMonthController = TextEditingController();
  final editEndMonthController = TextEditingController();

  bool enableCreate = false;

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

  Future<List<MultiSelectBottomSheetModel>> getSkillSet(String token) async {
    final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/skillset/getAllSkillSet');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    var skillSetData = [...json.decode(response.body)['result']];

    List<MultiSelectBottomSheetModel> tempSkillSetItems = [];

    for (var item in skillSetData) {
      tempSkillSetItems.add(MultiSelectBottomSheetModel(
        id: item['id'],
        name: item['name'],
        isSelected: false,
      ));
    }

    return tempSkillSetItems;
  }

  void getStudent(String token, dynamic student) async {
    setState(() {
      isGettingExp = true;
    });

    skillSetItems = await getSkillSet(token);

    setState(() {
      isGettingExp = false;
    });
  }

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);
    final student = ref.read(studentProvider);
    final studentInput = ref.read(studentInputProvider);
    getStudent(user.token!, student);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    var studentInput = ref.watch(studentInputProvider);
    var student = ref.watch(studentProvider);
    var Language = ref.watch(LanguageProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isGettingExp
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Language.Experiences,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      Language.DescriptionEx,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Language.Projects,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            titleController.text = '';
                            descriptionController.text = '';
                            startMonthController.text = '';
                            endMonthController.text = '';

                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.white,
                              builder: (ctx) {
                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                  // bool enable = false;
                                  final studentInputModal = ref.watch(studentInputProvider);

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: SingleChildScrollView(
                                      // physics: const NeverScrollableScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 40),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                Language.CreaProject,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black, //                   <--- border color
                                                  width: 0.3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              height: 580,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.Title,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: titleController,
                                                      onChanged: (data) {
                                                        if (titleController.text.isEmpty || descriptionController.text.isEmpty || startMonthController.text.isEmpty || endMonthController.text.isEmpty) {
                                                          enableCreate = false;
                                                        } else {
                                                          enableCreate = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      decoration: InputDecoration(
                                                        // labelText: 'Number of students',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                          borderSide: const BorderSide(color: Colors.black),
                                                        ),
                                                        contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 14,
                                                          horizontal: 15,
                                                        ),
                                                        hintText: Language.textTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.textDescription,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: descriptionController,
                                                      onChanged: (data) {
                                                        if (titleController.text.isEmpty || descriptionController.text.isEmpty || startMonthController.text.isEmpty || endMonthController.text.isEmpty) {
                                                          enableCreate = false;
                                                        } else {
                                                          enableCreate = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      decoration: InputDecoration(
                                                        // labelText: 'Number of students',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                          borderSide: const BorderSide(color: Colors.black),
                                                        ),
                                                        contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 14,
                                                          horizontal: 15,
                                                        ),
                                                        hintText: Language.textDescription,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          Language.Stime,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 118),
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          Language.Etime,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 175,
                                                        child: TextField(
                                                          controller: startMonthController,
                                                          onChanged: (data) {
                                                            if (titleController.text.isEmpty || descriptionController.text.isEmpty || startMonthController.text.isEmpty || endMonthController.text.isEmpty) {
                                                              enableCreate = false;
                                                            } else {
                                                              enableCreate = true;
                                                            }
                                                            setState(() {});
                                                          },
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                          decoration: InputDecoration(
                                                            // labelText: 'Number of students',
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(9),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(9),
                                                              borderSide: const BorderSide(color: Colors.black),
                                                            ),
                                                            contentPadding: const EdgeInsets.symmetric(
                                                              vertical: 14,
                                                              horizontal: 15,
                                                            ),
                                                            hintText: Language.textSTime,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      SizedBox(
                                                        width: 175,
                                                        child: TextField(
                                                          controller: endMonthController,
                                                          onChanged: (data) {
                                                            if (titleController.text.isEmpty || descriptionController.text.isEmpty || startMonthController.text.isEmpty || endMonthController.text.isEmpty) {
                                                              enableCreate = false;
                                                            } else {
                                                              enableCreate = true;
                                                            }
                                                            setState(() {});
                                                          },
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                          decoration: InputDecoration(
                                                            // labelText: 'Number of students',
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(9),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(9),
                                                              borderSide: const BorderSide(color: Colors.black),
                                                            ),
                                                            contentPadding: const EdgeInsets.symmetric(
                                                              vertical: 14,
                                                              horizontal: 15,
                                                            ),
                                                            hintText: Language.textETime,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.Skillset,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  MultiSelectBottomSheet(
                                                    // defaultList: defaultListAll[defaultListAll.length - 1],
                                                    // filterList: filterListAll[filterListAll.length - 1],
                                                    items: skillSetItems,
                                                    expEachElement: [],
                                                    width: MediaQuery.of(context).size.width,
                                                    bottomSheetHeight: 500 * 0.7, // required for min/max height of bottomSheet
                                                    hint: Language.SelectSkillset,
                                                    controller: controller,
                                                    searchTextFieldWidth: 300 * 0.96,
                                                    searchIcon: const Icon(
                                                        // required for searchIcon
                                                        Icons.search,
                                                        color: Colors.black87,
                                                        size: 22),
                                                    selectTextStyle: const TextStyle(color: Colors.white, fontSize: 17),
                                                    unSelectTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
                                                  ),
                                                  const SizedBox(height: 40),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            height: 46,
                                                            width: 175,
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                titleController.text = '';
                                                                descriptionController.text = '';
                                                                startMonthController.text = '';
                                                                endMonthController.text = '';
                                                                Navigator.pop(context);
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                // minimumSize: Size.zero, // Set this
                                                                padding: EdgeInsets.zero, // and this
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  side: const BorderSide(color: Colors.black),
                                                                ),
                                                                backgroundColor: Colors.white,
                                                              ),
                                                              child: Text(
                                                                Language.cancel,
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 15),
                                                          SizedBox(
                                                            height: 46,
                                                            width: 175,
                                                            child: ElevatedButton(
                                                              onPressed: enableCreate
                                                                  ? () {
                                                                      final skillSetsWithoutRef = [...studentInputModal.skillSetsForExp!];

                                                                      ref.read(studentInputProvider.notifier).addStudentInputExperiences(
                                                                            ExperienceCreate(
                                                                              titleController.text,
                                                                              descriptionController.text,
                                                                              startMonthController.text,
                                                                              endMonthController.text,
                                                                              skillSetsWithoutRef,
                                                                            ),
                                                                          );
                                                                      Navigator.pop(context);
                                                                    }
                                                                  : null,
                                                              style: ElevatedButton.styleFrom(
                                                                // minimumSize: Size.zero, // Set this
                                                                padding: EdgeInsets.zero, // and this
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                backgroundColor: Colors.black,
                                                              ),
                                                              child: Text(
                                                                Language.save,
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: const Icon(
                            Icons.add_circle,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    studentInput.experiences!.isEmpty
                        ? Column(
                            children: [
                              Text(
                                Language.empty,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                            ],
                          )
                        : Column(
                            children: [
                              ...studentInput.experiences!.map(
                                (el) {
                                  String elTitle = '';
                                  for (int i = 0; i < el.skillSets.length; i++) {
                                    if (i != el.skillSets.length - 1) {
                                      elTitle += '${skillSetItems[el.skillSets[i] - 1].name}, ';
                                    } else {
                                      elTitle += '${skillSetItems[el.skillSets[i] - 1].name}';
                                    }
                                  }
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        el.title,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${el.startMonth} - ${el.endMonth}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(255, 94, 94, 94),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          isScrollControlled: true,
                                                          context: context,
                                                          backgroundColor: Colors.white,
                                                          builder: (ctx) {
                                                            return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                              // bool enable = false;
                                                              editTitleController.text = el.title;
                                                              editDescriptionController.text = el.description;
                                                              editStartMonthController.text = el.startMonth;
                                                              editEndMonthController.text = el.endMonth;
                                                              return Padding(
                                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                child: SingleChildScrollView(
                                                                  // physics: const NeverScrollableScrollPhysics(),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        const SizedBox(height: 40),
                                                                        Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            Language.EditProject,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 25,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                              color: Colors.black, //                   <--- border color
                                                                              width: 0.3,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        SizedBox(
                                                                          height: 580,
                                                                          child: Column(
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  Language.Title,
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 15),
                                                                              SizedBox(
                                                                                child: TextField(
                                                                                  controller: editTitleController,
                                                                                  onChanged: (data) {},
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                  decoration: InputDecoration(
                                                                                    // labelText: 'Number of students',
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                      borderSide: const BorderSide(color: Colors.black),
                                                                                    ),
                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 14,
                                                                                      horizontal: 15,
                                                                                    ),
                                                                                    hintText: Language.textTitle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 20),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  Language.Description,
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 15),
                                                                              SizedBox(
                                                                                child: TextField(
                                                                                  controller: editDescriptionController,
                                                                                  onChanged: (data) {},
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                  decoration: InputDecoration(
                                                                                    // labelText: 'Number of students',
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                      borderSide: const BorderSide(color: Colors.black),
                                                                                    ),
                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 14,
                                                                                      horizontal: 15,
                                                                                    ),
                                                                                    hintText: Language.textDescription,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 20),
                                                                              Row(
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Text(
                                                                                      Language.Stime,
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 118,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Text(
                                                                                      Language.Etime,
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: 15),
                                                                              Row(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 175,
                                                                                    child: TextField(
                                                                                      controller: editStartMonthController,
                                                                                      onChanged: (data) {},
                                                                                      style: const TextStyle(
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                      decoration: InputDecoration(
                                                                                        // labelText: 'Number of students',
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(9),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(9),
                                                                                          borderSide: const BorderSide(color: Colors.black),
                                                                                        ),
                                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                                          vertical: 14,
                                                                                          horizontal: 15,
                                                                                        ),
                                                                                        hintText: Language.textSTime,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 15),
                                                                                  SizedBox(
                                                                                    width: 175,
                                                                                    child: TextField(
                                                                                      controller: editEndMonthController,
                                                                                      onChanged: (data) {},
                                                                                      style: const TextStyle(
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                      decoration: InputDecoration(
                                                                                        // labelText: 'Number of students',
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(9),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(9),
                                                                                          borderSide: const BorderSide(color: Colors.black),
                                                                                        ),
                                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                                          vertical: 14,
                                                                                          horizontal: 15,
                                                                                        ),
                                                                                        hintText: Language.textETime,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: 20),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  Language.Skillset,
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 15),
                                                                              MultiSelectBottomSheet(
                                                                                items: skillSetItems,
                                                                                expEachElement: el.skillSets,
                                                                                width: MediaQuery.of(context).size.width,

                                                                                bottomSheetHeight: 500 * 0.7, // required for min/max height of bottomSheet
                                                                                hint: Language.Skillset,
                                                                                controller: controller,
                                                                                searchTextFieldWidth: 300 * 0.96,
                                                                                searchIcon: const Icon(
                                                                                    // required for searchIcon
                                                                                    Icons.search,
                                                                                    color: Colors.black87,
                                                                                    size: 22),
                                                                                selectTextStyle: const TextStyle(color: Colors.white, fontSize: 17),
                                                                                unSelectTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
                                                                              ),
                                                                              const SizedBox(height: 40),
                                                                              Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        height: 46,
                                                                                        width: 175,
                                                                                        child: ElevatedButton(
                                                                                          onPressed: () {
                                                                                            titleController.text = '';
                                                                                            descriptionController.text = '';
                                                                                            startMonthController.text = '';
                                                                                            endMonthController.text = '';
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            // minimumSize: Size.zero, // Set this
                                                                                            padding: EdgeInsets.zero, // and this
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                              side: const BorderSide(color: Colors.black),
                                                                                            ),
                                                                                            backgroundColor: Colors.white,
                                                                                          ),
                                                                                          child: Text(
                                                                                            Language.cancel,
                                                                                            style: TextStyle(
                                                                                              fontSize: 18,
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(width: 15),
                                                                                      SizedBox(
                                                                                        height: 46,
                                                                                        width: 175,
                                                                                        child: ElevatedButton(
                                                                                          onPressed: () {
                                                                                            final studentAfterEdit = ref.watch(studentInputProvider);

                                                                                            ref.read(studentInputProvider.notifier).updateStudentInputExperiences(
                                                                                                  editTitleController.text,
                                                                                                  editDescriptionController.text,
                                                                                                  editStartMonthController.text,
                                                                                                  editEndMonthController.text,
                                                                                                  studentAfterEdit.skillSetsForExp!,
                                                                                                  studentInput.experiences!.indexOf(el),
                                                                                                );
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            // minimumSize: Size.zero, // Set this
                                                                                            padding: EdgeInsets.zero, // and this
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                            ),
                                                                                            backgroundColor: Colors.black,
                                                                                          ),
                                                                                          child: Text(
                                                                                            Language.save,
                                                                                            style: TextStyle(
                                                                                              fontSize: 18,
                                                                                              color: Color.fromARGB(255, 255, 255, 255),
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.edit_calendar,
                                                        color: Colors.black,
                                                        size: 24,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () {
                                                        ref.read(studentInputProvider.notifier).deleteStudentInputExperiences(
                                                              studentInput.experiences!.indexOf(el),
                                                            );
                                                      },
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
                                              Text(
                                                el.description,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                Language.Skillset,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                elTitle,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 46,
                        width: 130,
                        child: ElevatedButton(
                          onPressed: () async {
                            print(user.token);
                            print(student.id);

                            ref.read(optionsProvider.notifier).setWidgetOption('ProfileInputStudentStep3', user.role!);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: Text(
                            Language.Next,
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
