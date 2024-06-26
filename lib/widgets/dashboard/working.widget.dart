import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/widgets/profile/profile_input_student_step1.widget.dart';
import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

import 'package:studenthub/providers/language/language.provider.dart';
import '../../providers/options.provider.dart';

import '../../providers/options.provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Project {
  final String projectId;
  final String title;
  final String createTime;
  final int projectScopeFlag;
  final int numberOfStudents;
  final String description;
  final int countProposals;
  final int countMessages;
  final int countHired;
  final int typeFlag;

  Project({
    required this.projectId,
    required this.title,
    required this.createTime,
    required this.projectScopeFlag,
    required this.numberOfStudents,
    required this.description,
    required this.countProposals,
    required this.countMessages,
    required this.countHired,
    required this.typeFlag,
  });

  Project.fromJson(Map<dynamic, dynamic> json)
      : projectId = json['projectId'],
        title = json['title'],
        createTime = json['createdAt'],
        projectScopeFlag = json['projectScopeFlag'],
        numberOfStudents = json['numberOfStudents'],
        description = json['description'],
        countProposals = json['countProposals'],
        countMessages = json['countMessages'],
        countHired = json['countHired'],
        typeFlag = json['typeFlag'];

  Map<dynamic, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'createdAt': createTime,
      'projectScopeFlag': projectScopeFlag,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'countProposals': countProposals,
      'countMessages': countMessages,
      'countHired': countHired,
      'typeFlag': typeFlag,
    };
  }
}

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

class WorkingWidget extends ConsumerStatefulWidget {
  const WorkingWidget({super.key});

  @override
  ConsumerState<WorkingWidget> createState() {
    return _WorkingWidgetState();
  }
}

class _WorkingWidgetState extends ConsumerState<WorkingWidget> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var numOfStudentsController = TextEditingController();

  int pickedScope = -1;

  List<Project> listProjects = [];
  bool isFetchingData = false;

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

  void getProjects(token, companyId, tmp) async {
    setState(() {
      isFetchingData = true;
    });

    print('---companyId---');
    print(companyId);

    final urlGetProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project/company/$companyId');

    final responseProjects = await http.get(
      urlGetProjects,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseProjectsData = json.decode(responseProjects.body);
    print('----responseProjectsData----');
    print(responseProjectsData['result']);

    List<Project> listProjectsGetFromRes = [];
    if (responseProjectsData['result'] != null) {
      for (var item in responseProjectsData['result']) {
        listProjectsGetFromRes.add(Project(
          projectId: item['id'].toString(),
          title: item['title'],
          createTime: '${tmp.Createat} ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          projectScopeFlag: item['projectScopeFlag'],
          numberOfStudents: item['numberOfStudents'],
          description: item['description'],
          countProposals: item['countProposals'],
          countMessages: item['countMessages'],
          countHired: item['countHired'],
          typeFlag: item['typeFlag'],
        ));
      }
    }

    setState(() {
      listProjects = [...listProjectsGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    final company = ref.read(companyProvider);
    final lang = ref.read(LanguageProvider);
    getProjects(user.token!, company.id, lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final student = ref.watch(studentProvider);
    final company = ref.watch(companyProvider);
    final projectId = ref.watch(projectIdProvider);

    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
    return SizedBox(
      height: 545,
      child: SingleChildScrollView(
        child: isFetchingData
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 240),
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
            : listProjects.where((el) => el.typeFlag == 1).isEmpty
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
                      ...listProjects.where((el) => el.typeFlag == 1).map((el) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(projectIdProvider.notifier).setProjectId(el.projectId.toString());

                                ref.read(optionsProvider.notifier).setWidgetOption('SendHireOffer', user.role!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorApp.colorBackgroundColor,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                              width: 300,
                                              child: Text(
                                                el.title,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: colorApp.colorTitle,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) {
                                                  return Container(
                                                    height: 330,
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      color: colorApp.colorBackgroundBootomSheet,
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 52,
                                                                    width: 168,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size.zero, // Set this
                                                                        padding: EdgeInsets.zero, // and this
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                        ),
                                                                        backgroundColor: colorApp.colorBorderBackground,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.format_indent_increase_rounded,
                                                                              size: 22,
                                                                              color: colorApp.colorBlackWhite,
                                                                            ),
                                                                            SizedBox(width: 5),
                                                                            Text(
                                                                              Language.Viewproposals,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                // color: Color.fromARGB(255, 255, 255, 255),
                                                                                color: colorApp.colorBlackWhite,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    height: 52,
                                                                    width: 168,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size.zero, // Set this
                                                                        padding: EdgeInsets.zero, // and this
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                        ),
                                                                        backgroundColor: colorApp.colorBorderBackground,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.message_outlined,
                                                                              size: 22,
                                                                              color: colorApp.colorBlackWhite,
                                                                            ),
                                                                            SizedBox(width: 5),
                                                                            Text(
                                                                              Language.ViewMessage,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: colorApp.colorBlackWhite,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    height: 52,
                                                                    width: 168,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size.zero, // Set this
                                                                        padding: EdgeInsets.zero, // and this
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                        ),
                                                                        backgroundColor: colorApp.colorBorderBackground,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.person_3,
                                                                              size: 22,
                                                                              color: colorApp.colorBlackWhite,
                                                                            ),
                                                                            SizedBox(width: 5),
                                                                            Text(
                                                                              Language.Viewhired,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: colorApp.colorBlackWhite,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 52,
                                                                    width: 168,
                                                                    child: ElevatedButton(
                                                                      onPressed: () async {
                                                                        final urlPatchprojects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project/${el.projectId}');

                                                                        final responsePatchProjects = await http.patch(
                                                                          urlPatchprojects,
                                                                          headers: {
                                                                            'Content-Type': 'application/json',
                                                                            'Authorization': 'Bearer ${user.token}',
                                                                          },
                                                                          body: json.encode({
                                                                            'projectScopeFlag': el.projectScopeFlag,
                                                                            'title': el.title,
                                                                            'description': el.description,
                                                                            'numberOfStudents': el.numberOfStudents,
                                                                            "typeFlag": 2,
                                                                          }),
                                                                        );

                                                                        final responsePatchProjectsData = json.decode(responsePatchProjects.body);
                                                                        print('----responsePatchProjectsData----');
                                                                        print(responsePatchProjectsData);

                                                                        if (responsePatchProjectsData.containsKey('errorDetails')) {
                                                                          if (responsePatchProjectsData['errorDetails'] is String) {
                                                                            showErrorToast('Error', responsePatchProjectsData['errorDetails']);
                                                                          } else {
                                                                            showErrorToast('Error', responsePatchProjectsData['errorDetails'][0]);
                                                                          }
                                                                        } else {
                                                                          Navigator.pop(context);
                                                                          getProjects(user.token, company.id, Language);
                                                                          showSuccessToast('Success', 'Project has been archived successfully');
                                                                        }
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size.zero, // Set this
                                                                        padding: EdgeInsets.zero, // and this
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                        ),
                                                                        backgroundColor: colorApp.colorBorderBackground,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.archive_outlined,
                                                                              size: 22,
                                                                              color: colorApp.colorBlackWhite,
                                                                            ),
                                                                            SizedBox(width: 5),
                                                                            Text(
                                                                              Language.CloseProject,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                // color: Color.fromARGB(255, 255, 255, 255),
                                                                                color: colorApp.colorBlackWhite,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    height: 52,
                                                                    width: 168,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                        titleController.text = el.title;
                                                                        descriptionController.text = el.description;
                                                                        numOfStudentsController.text = '${el.numberOfStudents}';
                                                                        pickedScope = el.projectScopeFlag;
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
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        const SizedBox(height: 30),
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            Language.edit,
                                                                                            style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 25,
                                                                                              color: colorApp.colorTitle,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(height: 10),
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                              color: colorApp.colorDivider as Color, //                   <--- border color
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
                                                                                                    color: colorApp.colorTitle,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(height: 15),
                                                                                              SizedBox(
                                                                                                child: TextField(
                                                                                                  controller: titleController,
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
                                                                                                    hintText: Language.textTitle,
                                                                                                    hintStyle: TextStyle(
                                                                                                      color: colorApp.colorText,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(height: 15),
                                                                                              Align(
                                                                                                alignment: Alignment.topLeft,
                                                                                                child: Text(
                                                                                                  Language.ProjectScope,
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorApp.colorTitle),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(height: 15),
                                                                                              Column(
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                    height: 30,
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: LabeledRadio(
                                                                                                      label: Language.Time_1,
                                                                                                      value: 0,
                                                                                                      textColor: colorApp.colorBlackWhite,
                                                                                                      groupValue: pickedScope, //projectPosting.scope,
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          pickedScope = value as int;
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 30,
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: LabeledRadio(
                                                                                                      label: Language.Time_2,
                                                                                                      value: 1,
                                                                                                      textColor: colorApp.colorBlackWhite,
                                                                                                      groupValue: pickedScope, //projectPosting.scope,
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          pickedScope = value as int;
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 30,
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: LabeledRadio(
                                                                                                      label: Language.Time_3,
                                                                                                      value: 2,
                                                                                                      textColor: colorApp.colorBlackWhite,
                                                                                                      groupValue: pickedScope, //projectPosting.scope,
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          pickedScope = value as int;
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 30,
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: LabeledRadio(
                                                                                                      label: Language.Time_4,
                                                                                                      value: 3,
                                                                                                      textColor: colorApp.colorBlackWhite,
                                                                                                      groupValue: pickedScope, //projectPosting.scope,
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          pickedScope = value as int;
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              const SizedBox(height: 15),
                                                                                              Align(
                                                                                                alignment: Alignment.topLeft,
                                                                                                child: Text(
                                                                                                  Language.TextStudent,
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
                                                                                                  controller: numOfStudentsController,
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
                                                                                                    hintText: Language.TextStudent,
                                                                                                    hintStyle: TextStyle(color: colorApp.colorText),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(height: 15),
                                                                                              Align(
                                                                                                alignment: Alignment.topLeft,
                                                                                                child: Text(
                                                                                                  Language.Description,
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
                                                                                                  controller: descriptionController,
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
                                                                                                    hintText: Language.textDescription,
                                                                                                    hintStyle: TextStyle(color: colorApp.colorText),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(height: 35),
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
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          style: ElevatedButton.styleFrom(
                                                                                                            minimumSize: Size.zero, // Set this
                                                                                                            padding: EdgeInsets.zero, // and this
                                                                                                            shape: RoundedRectangleBorder(
                                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                                              side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                                            ),
                                                                                                            backgroundColor: colorApp.colorWhiteBlack,
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
                                                                                                          onPressed: () async {
                                                                                                            final urlEditProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project/${el.projectId}');

                                                                                                            final responseEditProjects = await http.patch(
                                                                                                              urlEditProjects,
                                                                                                              headers: {
                                                                                                                'Content-Type': 'application/json',
                                                                                                                'Authorization': 'Bearer ${user.token}',
                                                                                                              },
                                                                                                              body: json.encode({
                                                                                                                'projectScopeFlag': pickedScope,
                                                                                                                'title': titleController.text,
                                                                                                                'numberOfStudents': int.parse(numOfStudentsController.text),
                                                                                                                'description': descriptionController.text,
                                                                                                                "typeFlag": el.typeFlag,
                                                                                                              }),
                                                                                                            );

                                                                                                            final responseEditProjectsData = json.decode(responseEditProjects.body);
                                                                                                            print('----responseEditProjectsData----');
                                                                                                            print(responseEditProjectsData);

                                                                                                            titleController.text = '';
                                                                                                            descriptionController.text = '';
                                                                                                            numOfStudentsController.text = '';
                                                                                                            pickedScope = -1;

                                                                                                            Navigator.pop(context);
                                                                                                            showSuccessToast('Success', 'Edit project successfully');
                                                                                                            getProjects(user.token, company.id, Language);
                                                                                                          },
                                                                                                          style: ElevatedButton.styleFrom(
                                                                                                            minimumSize: Size.zero, // Set this
                                                                                                            padding: EdgeInsets.zero, // and this
                                                                                                            shape: RoundedRectangleBorder(
                                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                                            ),
                                                                                                            backgroundColor: colorApp.colorBlackWhite,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            Language.edit,
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
                                                                      style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size.zero, // Set this
                                                                        padding: EdgeInsets.zero, // and this
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                        ),
                                                                        backgroundColor: colorApp.colorBorderBackground,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.edit_calendar_outlined,
                                                                              size: 22,
                                                                              color: colorApp.colorBlackWhite,
                                                                            ),
                                                                            SizedBox(width: 5),
                                                                            Text(
                                                                              Language.EditProject,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: colorApp.colorBlackWhite,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    height: 52,
                                                                    width: 168,
                                                                    child: ElevatedButton(
                                                                      onPressed: () async {
                                                                        final urlDeleteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project/${el.projectId}');

                                                                        final responseDeleteProjects = await http.delete(
                                                                          urlDeleteProjects,
                                                                          headers: {
                                                                            'Content-Type': 'application/json',
                                                                            'Authorization': 'Bearer ${user.token}',
                                                                          },
                                                                        );

                                                                        final responseDeleteProjectsData = json.decode(responseDeleteProjects.body);
                                                                        print('----responseDeleteProjectsData----');
                                                                        print(el.projectId);
                                                                        print(responseDeleteProjectsData);

                                                                        Navigator.pop(context);
                                                                        getProjects(user.token, company.id, Language);
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                        minimumSize: Size.zero, // Set this
                                                                        padding: EdgeInsets.zero, // and this
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                        ),
                                                                        backgroundColor: colorApp.colorBorderBackground,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.delete_forever,
                                                                              size: 22,
                                                                              color: Colors.red,
                                                                            ),
                                                                            SizedBox(width: 5),
                                                                            Text(
                                                                              Language.Removepost,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: Colors.red,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 20),
                                                          SizedBox(
                                                            height: 52,
                                                            width: MediaQuery.of(context).size.width,
                                                            child: ElevatedButton(
                                                              onPressed: () {},
                                                              style: ElevatedButton.styleFrom(
                                                                minimumSize: Size.zero, // Set this
                                                                padding: EdgeInsets.zero, // and this
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  side: const BorderSide(color: Colors.grey),
                                                                ),
                                                                backgroundColor: colorApp.colorBlackWhite,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.only(left: 10),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      Language.StartWorking,
                                                                      style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: colorApp.colorWhiteBlack,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.more_vert,
                                              color: colorApp.colorIcon,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 340,
                                          child: Text(
                                            el.createTime,
                                            style: TextStyle(
                                              color: colorApp.colorTime,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 340,
                                          child: Text(
                                            '${Language.Time}: ${el.projectScopeFlag == 0 ? Language.Time_1 : el.projectScopeFlag == 1 ? Language.Time_2 : el.projectScopeFlag == 2 ? Language.Time_3 : Language.Time_4}, ${el.numberOfStudents} ${Language.StudentNeed}',
                                            style: TextStyle(
                                              color: colorApp.colorText,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: colorApp.colorDivider as Color, //                   <--- border color
                                            width: 0.3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          el.description,
                                          style: TextStyle(
                                            color: colorApp.colorText,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: colorApp.colorDivider as Color, //                   <--- border color
                                            width: 0.3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${el.countProposals}',
                                                style: TextStyle(
                                                  color: colorApp.colorText,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                Language.Proposals,
                                                style: TextStyle(
                                                  color: colorApp.colorTitle,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 50),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${el.countMessages}',
                                                style: TextStyle(
                                                  color: colorApp.colorText,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                Language.Message,
                                                style: TextStyle(
                                                  color: colorApp.colorTitle,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 50),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${el.countHired}',
                                                style: TextStyle(
                                                  color: colorApp.colorText,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                Language.Hired,
                                                style: TextStyle(
                                                  color: colorApp.colorTitle,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        );
                      }),
                    ],
                  ),
      ),
    );
  }
}
