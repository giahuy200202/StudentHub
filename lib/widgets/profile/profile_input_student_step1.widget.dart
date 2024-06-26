import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/profile/student_input.provider.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet_model.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toastification/toastification.dart';

TextEditingController controller = TextEditingController();

class Teachstack {
  String id;
  String name;

  Teachstack(this.id, this.name);

  Teachstack.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class LanguageCreate {
  String languageName;
  String level;

  LanguageCreate(this.languageName, this.level);

  LanguageCreate.fromJson(Map<dynamic, dynamic> json)
      : languageName = json['languageName'],
        level = json['level'];

  Map<dynamic, dynamic> toJson() {
    return {
      'languageName': languageName,
      'level': level,
    };
  }
}

class LanguageFetch {
  int? id;
  String languageName;
  String level;

  LanguageFetch(this.id, this.languageName, this.level);

  LanguageFetch.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        languageName = json['languageName'],
        level = json['level'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'languageName': languageName,
      'level': level,
    };
  }
}

class EducationCreate {
  String schoolName;
  String startYear;
  String endYear;

  EducationCreate(this.schoolName, this.startYear, this.endYear);

  EducationCreate.fromJson(Map<dynamic, dynamic> json)
      : schoolName = json['schoolName'],
        startYear = json['startYear'],
        endYear = json['endYear'];

  Map<dynamic, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'startYear': startYear,
      'endYear': endYear,
    };
  }
}

class EducationFetch {
  int? id;
  String schoolName;
  String startYear;
  String endYear;

  EducationFetch(this.id, this.schoolName, this.startYear, this.endYear);

  EducationFetch.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        schoolName = json['schoolName'],
        startYear = json['startYear'],
        endYear = json['endYear'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'schoolName': schoolName,
      'startYear': startYear,
      'endYear': endYear,
    };
  }
}

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

class ProfileIStudentWidget extends ConsumerStatefulWidget {
  const ProfileIStudentWidget({super.key});

  @override
  ConsumerState<ProfileIStudentWidget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget extends ConsumerState<ProfileIStudentWidget> {
  List<Teachstack> techStack = [];
  List<String> techStackName = [];
  List<String> techStackId = [];
  // late Future<List<MultiSelectBottomSheetModel>> selectSkillSetItem;
  List<MultiSelectBottomSheetModel> skillSetItems = [];
  //List<LanguageData> languages = [];

  String dropdownValue = '';
  // String dropdownValue = '1';

  final fullnameController = TextEditingController();

  final createLanguagesController = TextEditingController();
  final createLanguageLevelController = TextEditingController();

  final editLanguagesController = TextEditingController();
  final editLanguageLevelController = TextEditingController();

  final createHighschoolController = TextEditingController();
  final createHighschoolStartYearController = TextEditingController();
  final createHighschoolEndYearController = TextEditingController();

  final editHighschoolController = TextEditingController();
  final editHighschoolStartYearController = TextEditingController();
  final editHighschoolEndYearController = TextEditingController();

  bool isFetchLanguage = false;
  bool isFetchEducation = false;
  bool isGettingStudent = false;

  bool enableCreate = false;
  bool enableEducation = false;

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

  Future<List<Teachstack>> getTechStack(String token) async {
    final url = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/techstack/getAllTechStack');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    var techStackData = [...json.decode(response.body)['result']];

    List<Teachstack> tempTechStack = [];
    // List<int> tempTechStackId = [];

    for (var item in techStackData) {
      tempTechStack.add(Teachstack(item['id'].toString(), item['name']));
      // tempTechStackName.add(item['name']);
      // tempTechStackId.add(item['id']);
    }

    dropdownValue = tempTechStack[0].id;

    return tempTechStack;
  }

  Future<List<MultiSelectBottomSheetModel>> getSkillSet(String token) async {
    final url = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/skillset/getAllSkillSet');

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
      isGettingStudent = true;
    });

    techStack = await getTechStack(token);
    techStackName = techStack.map((e) => e.name).toList();
    print('----techStackName----');
    print(techStackName.runtimeType);
    techStackId = techStack.map((e) => e.id.toString()).toList();
    print('----techStackId----');
    print(techStackId.runtimeType);

    skillSetItems = await getSkillSet(token);

    if (student.id != 0) {
      //set techstackId,  dropdown value
      // dropdownValue = techStackName[student.techStackId - 1];
      print('----student.id !==0 ----');
      print(student.techStackId);

      dropdownValue = techStack
          .firstWhere(
            (element) => element.id == student.techStackId.toString(),
          )
          .id;
      print('----dropdownValue----');
      print(dropdownValue);

      ref.read(studentInputProvider.notifier).setStudentInputTechstackId(student.techStackId);

      print('----student.techStackId----');
      print(json.encode(student.techStackId));

      //set selected skillset
      ref.read(studentInputProvider.notifier).setStudentInputSkillSet(student.skillSets);

      for (var item in student.skillSets) {
        skillSetItems[item - 1].isSelected = true;
      }

      print('----student.skillSets----');
      print(json.encode(student.skillSets));

      //set fullname
      fullnameController.text = student.fullname;
      ref.read(studentInputProvider.notifier).setStudentInputFullname(student.fullname);

      print('----student.fullname----');
      print(json.encode(student.fullname));

      //set languages
      ref.read(studentInputProvider.notifier).setStudentInputLanguague([]);

      final urlEducation = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/language/getByStudentId/${student.id}');
      final responseEditEducations = await http.get(
        urlEducation,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );

      var responseEditEducationsData = json.decode(responseEditEducations.body);

      for (var item in student.languages) {
        ref.read(studentInputProvider.notifier).addStudentInputLanguague(
              LanguageFetch(item['id'], item['languageName'], item['level']),
            );
      }

      print('----student.languages----');
      print(json.encode(student.languages));

      //set educations
      ref.read(studentInputProvider.notifier).setStudentInputEducation([]);
      for (var item in student.educations) {
        ref.read(studentInputProvider.notifier).addStudentInputEducation(
              EducationFetch(
                item['id'],
                item['schoolName'],
                '${item['startYear']}',
                '${item['endYear']}',
              ),
            );
      }

      print('----student.educations----');
      print(json.encode(student.educations));

      //set experiences
      ref.read(studentInputProvider.notifier).setStudentInputExperiences([]);
      for (var item in student.experiences) {
        List<int> tempSkillSet = [];
        print('----skillSets----');
        print(item);
        if (item['skillSets'] != null) {
          for (var i in item['skillSets']) {
            tempSkillSet.add(i['id']);
          }
        }

        ref.read(studentInputProvider.notifier).addStudentInputExperiences(
              ExperienceFetch(
                item['id'],
                item['title'],
                item['description'],
                item['startMonth'],
                item['endMonth'],
                // '${int.parse(item['startMonth'].subString(0, 4)) + 1}',
                // '${int.parse(item['endMonth'].subString(0, 4)) + 1}',
                tempSkillSet,
              ),
            );
      }

      //set resume
      ref.read(studentInputProvider.notifier).setStudentInputResume(student.resume);
      print('----student.resume----');
      print(json.encode(student.resume));

      //set transcript
      ref.read(studentInputProvider.notifier).setStudentInputTranscript(student.transcript);
      print('----student.transcript----');
      print(json.encode(student.transcript));
    } else {
      ref.read(studentInputProvider.notifier).setStudentInputTechstackId(student.techStackId);
      ref.read(studentInputProvider.notifier).setStudentInputSkillSet(student.skillSets);
      ref.read(studentInputProvider.notifier).setStudentInputFullname(student.fullname);
      ref.read(studentInputProvider.notifier).setStudentInputLanguague(student.languages);
      ref.read(studentInputProvider.notifier).setStudentInputEducation(student.educations);
      ref.read(studentInputProvider.notifier).setStudentInputExperiences(student.experiences);
      ref.read(studentInputProvider.notifier).setStudentInputResume(student.resume);
      ref.read(studentInputProvider.notifier).setStudentInputTranscript(student.transcript);
    }

    setState(() {
      isGettingStudent = false;
    });
  }

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);
    final student = ref.read(studentProvider);

    getStudent(user.token!, student);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final student = ref.watch(studentProvider);
    final studentInput = ref.watch(studentInputProvider);
    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isGettingStudent
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
                        Language.TitleStudentProfile,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: colorApp.colorTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Language.DescriptionStudentProfile,
                      style: TextStyle(fontSize: 16, color: colorApp.colorText),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Language.Fullname,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: colorApp.colorTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: TextField(
                        controller: fullnameController,
                        onChanged: (data) {
                          ref.read(studentInputProvider.notifier).setStudentInputFullname(
                                fullnameController.text,
                              );
                          if (createLanguagesController.text.isEmpty || createLanguageLevelController.text.isEmpty) {
                            enableCreate = false;
                          } else {
                            enableCreate = true;
                          }
                          setState(() {});
                        },
                        style: TextStyle(
                          fontSize: 16,
                          color: colorApp.colorText,
                        ),
                        decoration: InputDecoration(
                            // labelText: 'Number of students',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 15,
                            ),
                            hintText: Language.EnterFullname,
                            hintStyle: TextStyle(color: colorApp.colorText)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Language.Techstack,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colorApp.colorTitle),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      dropdownColor: colorApp.colorBorderBackground,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: colorApp.colorBackgroundColor,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13.5),
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
                          // dropdownValue = techStackName[int.parse(value!) - 1];
                          print('-----value-----');
                          print(value);
                          // dropdownValue = techStack
                          //     .firstWhere(
                          //       (element) => element.id == value,
                          //     )
                          //     .name;
                          dropdownValue = value!;
                        });

                        ref.read(studentInputProvider.notifier).setStudentInputTechstackId(
                              // techStackName.indexOf(dropdownValue) + 1,
                              int.parse(value!),
                            );
                      },
                      items: techStackId.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            techStack
                                .firstWhere(
                                  (element) => element.id == value,
                                )
                                .name,
                            // value,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: colorApp.colorText),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Language.Skillset,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorApp.colorTitle,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MultiSelectBottomSheet(
                      items: skillSetItems, // required for Item list
                      width: 370,
                      bottomSheetHeight: 500 * 0.7, // required for min/max height of bottomSheet
                      hint: Language.SelectSkillset,
                      hintColor: colorApp.colorText as Color,
                      controller: controller,
                      selectedBackgroundColor: colorApp.colorBackgroundColor as Color,
                      searchTextFieldWidth: 300 * 0.96,
                      searchIcon: const Icon(
                          // required for searchIcon
                          Icons.search,
                          color: Colors.black,
                          size: 22),
                      selectTextStyle: const TextStyle(color: Colors.white, fontSize: 17),
                      unSelectTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Language.language,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colorApp.colorTitle),
                        ),

                        //Create language
                        InkWell(
                          onTap: () {
                            createLanguagesController.text = '';
                            createLanguageLevelController.text = '';
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: colorApp.colorBackgroundBootomSheet,
                              builder: (ctx) {
                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                  // bool enable = false;
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
                                                Language.CreateLang,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: colorApp.colorTitle,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: colorApp.colorBorderSide as Color, //                   <--- border color
                                                  width: 0.3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 580,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.language,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: colorApp.colorTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: createLanguagesController,
                                                      onChanged: (data) {
                                                        if (createLanguagesController.text.isEmpty || createLanguageLevelController.text.isEmpty) {
                                                          enableCreate = false;
                                                        } else {
                                                          enableCreate = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorApp.colorText,
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
                                                        hintText: Language.textLanguage,
                                                        hintStyle: TextStyle(color: colorApp.colorText),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.Level,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: colorApp.colorTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: createLanguageLevelController,
                                                      onChanged: (data) {
                                                        if (createLanguagesController.text.isEmpty || createLanguageLevelController.text.isEmpty) {
                                                          enableCreate = false;
                                                        } else {
                                                          enableCreate = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorApp.colorText,
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
                                                        hintText: Language.textLevel,
                                                        hintStyle: TextStyle(color: colorApp.colorText),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 300),
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
                                                                createLanguagesController.text = '';
                                                                createLanguageLevelController.text = '';
                                                                setState(
                                                                  () {
                                                                    enableCreate = false;
                                                                  },
                                                                );
                                                                Navigator.pop(context);
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                minimumSize: Size.zero, // Set this
                                                                padding: EdgeInsets.zero, // and this
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                ),
                                                                backgroundColor: colorApp.colorunSelect,
                                                              ),
                                                              child: Text(
                                                                Language.cancel,
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: colorApp.colorBlackWhite,
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
                                                                      ref.read(studentInputProvider.notifier).addStudentInputLanguague(
                                                                            LanguageCreate(
                                                                              createLanguagesController.text,
                                                                              createLanguageLevelController.text,
                                                                            ),
                                                                          );
                                                                      Navigator.pop(context);
                                                                    }
                                                                  : null,
                                                              style: ElevatedButton.styleFrom(
                                                                minimumSize: Size.zero, // Set this
                                                                padding: EdgeInsets.zero, // and this
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                backgroundColor: colorApp.colorBlackWhite,
                                                                disabledBackgroundColor: colorApp.colorButton,
                                                              ),
                                                              child: Text(
                                                                Language.save,
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: colorApp.colorWhiteBlack,
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
                          child: Icon(
                            Icons.add_circle,
                            color: colorApp.colorIcon,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    //Language
                    studentInput.languages!.isEmpty
                        ? Column(
                            children: [
                              Text(
                                Language.empty,
                                style: TextStyle(fontSize: 16, color: colorApp.colorText),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                        : Column(
                            children: [
                              ...studentInput.languages!.map((el) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: colorApp.colorBackgroundColor,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: Text(
                                                '${el.languageName} - ${el.level}',
                                                style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis, color: colorApp.colorText),
                                              ),
                                            ),
                                            Row(children: [
                                              InkWell(
                                                onTap: () {
                                                  editLanguagesController.text = el.languageName;
                                                  editLanguageLevelController.text = el.level;
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: colorApp.colorBackgroundBootomSheet,
                                                    builder: (ctx) {
                                                      return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
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
                                                                      Language.EditLang,
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 25,
                                                                        color: colorApp.colorTitle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 15),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        color: colorApp.colorBorderSide as Color, //                   <--- border color
                                                                        width: 0.3,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    height: 580,
                                                                    child: Column(
                                                                      children: [
                                                                        Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            Language.language,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              color: colorApp.colorTitle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        SizedBox(
                                                                          child: TextField(
                                                                            controller: editLanguagesController,
                                                                            onChanged: (data) {},
                                                                            style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: colorApp.colorText,
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                                // labelText: 'Number of students',
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(9),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(9),
                                                                                  borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                                ),
                                                                                contentPadding: const EdgeInsets.symmetric(
                                                                                  vertical: 14,
                                                                                  horizontal: 15,
                                                                                ),
                                                                                hintText: Language.textLanguage,
                                                                                hintStyle: TextStyle(
                                                                                  color: colorApp.colorText,
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 20),
                                                                        Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            Language.Level,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              color: colorApp.colorTitle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        SizedBox(
                                                                          child: TextField(
                                                                            controller: editLanguageLevelController,
                                                                            onChanged: (data) {},
                                                                            style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: colorApp.colorText,
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
                                                                                hintText: Language.textLevel,
                                                                                hintStyle: TextStyle(color: colorApp.colorText)),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 300),
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
                                                                                      editLanguagesController.text = '';
                                                                                      editLanguageLevelController.text = '';
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      minimumSize: Size.zero, // Set this
                                                                                      padding: EdgeInsets.zero, // and this
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                        side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                      ),
                                                                                      backgroundColor: colorApp.colorunSelect,
                                                                                    ),
                                                                                    child: Text(
                                                                                      Language.cancel,
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                        color: colorApp.colorBlackWhite,
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
                                                                                      ref.read(studentInputProvider.notifier).updateStudentInputLanguague(
                                                                                            editLanguagesController.text,
                                                                                            editLanguageLevelController.text,
                                                                                            studentInput.languages!.indexOf(el),
                                                                                          );
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      minimumSize: Size.zero, // Set this
                                                                                      padding: EdgeInsets.zero, // and this
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                      backgroundColor: colorApp.colorBlackWhite,
                                                                                      disabledBackgroundColor: colorApp.colorButton,
                                                                                    ),
                                                                                    child: Text(
                                                                                      Language.save,
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                        color: colorApp.colorWhiteBlack,
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
                                                child: Icon(
                                                  Icons.edit_calendar,
                                                  color: colorApp.colorIcon,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  ref.read(studentInputProvider.notifier).deleteStudentInputLanguague(
                                                        studentInput.languages!.indexOf(el),
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
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                );
                              })
                            ],
                          ),

                    //Education
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Language.Education,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorApp.colorTitle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            createHighschoolController.text = '';
                            createHighschoolStartYearController.text = '';
                            createHighschoolEndYearController.text = '';

                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: colorApp.colorBackgroundBootomSheet,
                              builder: (ctx) {
                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
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
                                                Language.Createeducation,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: colorApp.colorTitle),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: colorApp.colorBorderSide as Color, //                   <--- border color
                                                  width: 0.3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 580,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.school,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: colorApp.colorTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: createHighschoolController,
                                                      onChanged: (data) {
                                                        if (createHighschoolController.text.isEmpty || createHighschoolStartYearController.text.isEmpty || createHighschoolEndYearController.text.isEmpty) {
                                                          enableEducation = false;
                                                        } else {
                                                          enableEducation = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorApp.colorText,
                                                      ),
                                                      decoration: InputDecoration(
                                                          // labelText: 'Number of students',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(9),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(9),
                                                            borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 15,
                                                          ),
                                                          hintText: Language.textSchool,
                                                          hintStyle: TextStyle(color: colorApp.colorText)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.schoolyear,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorApp.colorTitle),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: createHighschoolStartYearController,
                                                      onChanged: (data) {
                                                        if (createHighschoolController.text.isEmpty || createHighschoolStartYearController.text.isEmpty || createHighschoolEndYearController.text.isEmpty) {
                                                          enableEducation = false;
                                                        } else {
                                                          enableEducation = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorApp.colorText,
                                                      ),
                                                      decoration: InputDecoration(
                                                        // labelText: 'Number of students',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                          borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                        ),
                                                        contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 14,
                                                          horizontal: 15,
                                                        ),
                                                        hintText: Language.textSchoolyear,
                                                        hintStyle: TextStyle(color: colorApp.colorText),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      Language.Endschoolyear,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: colorApp.colorTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: TextField(
                                                      controller: createHighschoolEndYearController,
                                                      onChanged: (data) {
                                                        if (createHighschoolController.text.isEmpty || createHighschoolStartYearController.text.isEmpty || createHighschoolEndYearController.text.isEmpty) {
                                                          enableEducation = false;
                                                        } else {
                                                          enableEducation = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorApp.colorText,
                                                      ),
                                                      decoration: InputDecoration(
                                                          // labelText: 'Number of students',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(9),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(9),
                                                            borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 15,
                                                          ),
                                                          hintText: Language.textEndSchoolyear,
                                                          hintStyle: TextStyle(
                                                            color: colorApp.colorText,
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 200),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 46,
                                                        width: 175,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            createHighschoolController.text = '';
                                                            createHighschoolStartYearController.text = '';
                                                            createHighschoolEndYearController.text = '';
                                                            setState(() {
                                                              enableEducation = false;
                                                            });

                                                            Navigator.pop(context);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                            ),
                                                            backgroundColor: colorApp.colorunSelect,
                                                          ),
                                                          child: Text(
                                                            Language.cancel,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: colorApp.colorBlackWhite,
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
                                                          onPressed: enableEducation
                                                              ? () {
                                                                  ref.read(studentInputProvider.notifier).addStudentInputEducation(
                                                                        EducationCreate(
                                                                          createHighschoolController.text,
                                                                          createHighschoolStartYearController.text,
                                                                          createHighschoolEndYearController.text,
                                                                        ),
                                                                      );
                                                                  Navigator.pop(context);
                                                                }
                                                              : null,
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            backgroundColor: colorApp.colorBlackWhite,
                                                            disabledBackgroundColor: colorApp.colorButton,
                                                          ),
                                                          child: Text(
                                                            Language.save,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: colorApp.colorWhiteBlack,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                          child: Icon(
                            Icons.add_circle,
                            color: colorApp.colorIcon,
                            size: 25,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    studentInput.educations!.isEmpty
                        ? Column(
                            children: [
                              Text(
                                Language.empty,
                                style: TextStyle(fontSize: 16, color: colorApp.colorText),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                        : Column(
                            children: [
                              ...studentInput.educations!.map((el) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: colorApp.colorBackgroundColor,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  el.schoolName,
                                                  style: TextStyle(fontSize: 16, color: colorApp.colorTitle),
                                                ),
                                                Text(
                                                  '${el.startYear} - ${el.endYear}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorApp.colorText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              InkWell(
                                                onTap: () {
                                                  editHighschoolController.text = el.schoolName;
                                                  editHighschoolStartYearController.text = el.startYear;
                                                  editHighschoolEndYearController.text = el.endYear;
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    backgroundColor: colorApp.colorBackgroundBootomSheet,
                                                    builder: (ctx) {
                                                      return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
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
                                                                      Language.Editeducation,
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 25,
                                                                        color: colorApp.colorTitle,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 15),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        color: colorApp.colorBorderSide as Color, //                   <--- border color
                                                                        width: 0.3,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    height: 580,
                                                                    child: Column(
                                                                      children: [
                                                                        Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            Language.school,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              color: colorApp.colorTitle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        SizedBox(
                                                                          child: TextField(
                                                                            controller: editHighschoolController,
                                                                            onChanged: (data) {},
                                                                            style: TextStyle(fontSize: 16, color: colorApp.colorText),
                                                                            decoration: InputDecoration(
                                                                                // labelText: 'Number of students',
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(9),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(9),
                                                                                  borderSide: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                ),
                                                                                contentPadding: const EdgeInsets.symmetric(
                                                                                  vertical: 14,
                                                                                  horizontal: 15,
                                                                                ),
                                                                                hintText: Language.textSchool,
                                                                                hintStyle: TextStyle(
                                                                                  color: colorApp.colorText,
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            Language.schoolyear,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              color: colorApp.colorTitle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        SizedBox(
                                                                          child: TextField(
                                                                            controller: editHighschoolStartYearController,
                                                                            onChanged: (data) {},
                                                                            style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: colorApp.colorText,
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
                                                                                hintText: Language.textSchoolyear,
                                                                                hintStyle: TextStyle(color: colorApp.colorText)),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Text(
                                                                            Language.Endschoolyear,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              color: colorApp.colorText,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 15),
                                                                        SizedBox(
                                                                          child: TextField(
                                                                            controller: editHighschoolEndYearController,
                                                                            onChanged: (data) {},
                                                                            style: TextStyle(fontSize: 16, color: colorApp.colorText),
                                                                            decoration: InputDecoration(
                                                                                // labelText: 'Number of students',
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(9),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(9),
                                                                                  borderSide: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                ),
                                                                                contentPadding: const EdgeInsets.symmetric(
                                                                                  vertical: 14,
                                                                                  horizontal: 15,
                                                                                ),
                                                                                hintText: Language.textEndSchoolyear,
                                                                                hintStyle: TextStyle(color: colorApp.colorText)),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 200),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 46,
                                                                              width: 175,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  editHighschoolController.text = '';
                                                                                  editHighschoolStartYearController.text = '';
                                                                                  editHighschoolEndYearController.text = '';
                                                                                  setState() {
                                                                                    enableEducation = false;
                                                                                  }

                                                                                  Navigator.pop(context);
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  minimumSize: Size.zero, // Set this
                                                                                  padding: EdgeInsets.zero, // and this
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                  ),
                                                                                  backgroundColor: colorApp.colorunSelect,
                                                                                ),
                                                                                child: Text(
                                                                                  Language.cancel,
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    color: colorApp.colorBlackWhite,
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
                                                                                  ref.read(studentInputProvider.notifier).updateStudentInputEducation(
                                                                                        editHighschoolController.text,
                                                                                        editHighschoolStartYearController.text,
                                                                                        editHighschoolEndYearController.text,
                                                                                        studentInput.educations!.indexOf(el),
                                                                                      );
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  minimumSize: Size.zero, // Set this
                                                                                  padding: EdgeInsets.zero, // and this
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                  backgroundColor: colorApp.colorBlackWhite,
                                                                                  disabledBackgroundColor: colorApp.colorButton,
                                                                                ),
                                                                                child: Text(
                                                                                  Language.save,
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    color: colorApp.colorWhiteBlack,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
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
                                                child: Icon(
                                                  Icons.edit_calendar,
                                                  color: colorApp.colorIcon,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  ref.read(studentInputProvider.notifier).deleteStudentInputEducation(
                                                        studentInput.educations!.indexOf(el),
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
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                );
                              }),
                            ],
                          ),

                    const SizedBox(height: 10),
                    (studentInput.techStackId != 0 && studentInput.skillSets!.isNotEmpty && studentInput.languages!.isNotEmpty && studentInput.educations!.isNotEmpty) || (student.id != 0)
                        ? Container(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 46,
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () async {
                                  ref.read(optionsProvider.notifier).setWidgetOption('ProfileInputStudentStep2', user.role!);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                  backgroundColor: colorApp.colorBlackWhite,
                                ),
                                child: Text(
                                  Language.Next,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: colorApp.colorWhiteBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
