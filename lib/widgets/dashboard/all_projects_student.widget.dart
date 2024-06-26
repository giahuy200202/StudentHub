import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';
import '../../providers/options.provider.dart';

import '../../providers/options.provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Project {
  final String proposalId;
  final String projectId;
  final String title;
  final String createTime;
  final int projectScopeFlag;
  final int numberOfStudents;
  final String description;
  final String coverLetter;
  final int statusFlag;

  Project({
    required this.proposalId,
    required this.projectId,
    required this.title,
    required this.createTime,
    required this.projectScopeFlag,
    required this.numberOfStudents,
    required this.description,
    required this.coverLetter,
    required this.statusFlag,
  });

  Project.fromJson(Map<dynamic, dynamic> json)
      : proposalId = json['proposalId'],
        projectId = json['projectId'],
        title = json['title'],
        createTime = json['createdAt'],
        projectScopeFlag = json['projectScopeFlag'],
        numberOfStudents = json['numberOfStudents'],
        description = json['description'],
        coverLetter = json['coverLetter'],
        statusFlag = json['statusFlag'];

  Map<dynamic, dynamic> toJson() {
    return {
      'proposalId': proposalId,
      'projectId': projectId,
      'title': title,
      'createdAt': createTime,
      'projectScopeFlag': projectScopeFlag,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
    };
  }
}

class AllProjectsStudentWidget extends ConsumerStatefulWidget {
  const AllProjectsStudentWidget({
    super.key,
  });
  @override
  ConsumerState<AllProjectsStudentWidget> createState() {
    return _AllProjectsStudentWidgetState();
  }
}

class _AllProjectsStudentWidgetState extends ConsumerState<AllProjectsStudentWidget> {
  List<Project> listProjects = [];
  bool isFetchingData = false;

  void getProjects(token, studentId, tmp) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetProposals = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/proposal/project/$studentId');

    final responseProposals = await http.get(
      urlGetProposals,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseProposalsData = json.decode(responseProposals.body);
    print('----responseProposalsData----');
    print(responseProposalsData['result']);

    List<Project> listProjectsGetFromRes = [];
    if (responseProposalsData['result'] != null) {
      for (var item in responseProposalsData['result']) {
        listProjectsGetFromRes.add(
          Project(
            proposalId: item['proposalId'].toString(),
            projectId: item['project']['id'].toString(),
            title: item['project']['title'],
            createTime: 'Submitted at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                  DateTime.parse(item['createdAt']).toLocal(),
                ).toString()}',
            projectScopeFlag: item['project']['projectScopeFlag'],
            numberOfStudents: item['project']['numberOfStudents'],
            description: item['project']['description'],
            coverLetter: item['coverLetter'],
            statusFlag: item['statusFlag'],
          ),
        );
      }
    }

    print('----listProjectsGetFromRes----');
    print(listProjectsGetFromRes);

    setState(() {
      listProjects = [...listProjectsGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    final student = ref.read(studentProvider);
    final lang = ref.read(LanguageProvider);
    getProjects(user.token!, student.id, lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
    final user = ref.read(userProvider);
    return SizedBox(
      height: 600,
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
            : Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        Language.Active + ' (${listProjects.where((el) => el.statusFlag == 1).toList().length})',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorApp.colorTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  listProjects.where((el) => el.statusFlag == 1 || el.statusFlag == 2).toList().isEmpty
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Language.empty,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: colorApp.colorText,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      : Column(
                          children: [
                            ...listProjects.where((el) => el.statusFlag == 1 || el.statusFlag == 2).toList().map((el) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref.read(projectIdProvider.notifier).setProjectId(el.projectId);
                                      ref.read(optionsProvider.notifier).setWidgetOption('ProjectDetails', user.role!);
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
                                          ],
                                        ),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        Language.Submitted + ' (${listProjects.where((el) => el.statusFlag == 0).toList().length})',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorApp.colorTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  listProjects.where((el) => el.statusFlag == 0).toList().isEmpty
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Language.empty,
                                style: TextStyle(fontSize: 16, color: colorApp.colorText),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : Column(
                          children: [
                            ...listProjects.where((el) => el.statusFlag == 0).toList().map((el) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref.read(projectIdProvider.notifier).setProjectId(el.projectId);
                                      ref.read(optionsProvider.notifier).setWidgetOption('ProjectDetails', user.role!);
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }),
                          ],
                        ),
                ],
              ),
      ),
    );
  }
}
