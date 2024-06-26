import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:toastification/toastification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

import 'package:studenthub/providers/language/language.provider.dart';
import '../../providers/options.provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Project {
  final String id;
  final String title;
  final String createTime;
  final int projectScopeFlag;
  final int numberOfStudents;
  final String description;
  final int countProposals;
  final bool isFavorite;

  Project({
    required this.id,
    required this.title,
    required this.createTime,
    required this.projectScopeFlag,
    required this.numberOfStudents,
    required this.description,
    required this.countProposals,
    required this.isFavorite,
  });

  Project.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'],
        createTime = json['createdAt'],
        projectScopeFlag = json['projectScopeFlag'],
        numberOfStudents = json['numberOfStudents'],
        description = json['description'],
        countProposals = json['countProposals'],
        isFavorite = json['isFavorite'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createTime,
      'projectScopeFlag': projectScopeFlag,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'countProposals': countProposals,
      'isFavorite': isFavorite,
    };
  }
}

class ListProjectsWidget extends ConsumerStatefulWidget {
  const ListProjectsWidget({super.key});

  @override
  ConsumerState<ListProjectsWidget> createState() {
    return _ListProjectsWidgetState();
  }
}

class _ListProjectsWidgetState extends ConsumerState<ListProjectsWidget> {
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

  void getProjects(token, tmp) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project?perPage=100000&page=1');

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
          id: item['id'].toString(),
          title: item['title'],
          createTime: '${tmp.Createat} ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          projectScopeFlag: item['projectScopeFlag'],
          numberOfStudents: item['numberOfStudents'],
          description: item['description'],
          countProposals: item['countProposals'],
          isFavorite: item['isFavorite'],
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
    final Lang = ref.read(LanguageProvider);
    getProjects(user.token!, Lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final student = ref.watch(studentProvider);
    final projectId = ref.watch(projectIdProvider);
    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
    print(student.id);

    return SizedBox(
      height: 590,
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
            : listProjects.isEmpty
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
                      ...listProjects.map((el) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(projectIdProvider.notifier).setProjectId(el.id.toString());

                                ref.read(optionsProvider.notifier).setWidgetOption('ProjectDetails', user.role!);
                                print('parent project id');
                                print(el.id);
                                ref.read(projectIdProvider.notifier).setProjectId(el.id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  // border: Border.all(color: Colors.grey),
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
                                            onTap: user.role == '1'
                                                ? null
                                                : () async {
                                                    print('-------project id-------');
                                                    print(el.id);
                                                    print('-------student id-------');
                                                    print(student.id);
                                                    final urlFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/${student.id}');

                                                    final responsePatchFavoriteProject = await http.patch(
                                                      urlFavoriteProjects,
                                                      headers: {
                                                        'Content-Type': 'application/json',
                                                        'Authorization': 'Bearer ${user.token!}',
                                                      },
                                                      body: json.encode({
                                                        'projectId': el.id,
                                                        'disableFlag': el.isFavorite ? 1 : 0,
                                                      }),
                                                    );

                                                    final responsePatchFavoriteProjectData = json.decode(responsePatchFavoriteProject.body);

                                                    print('----responsePatchFavoriteProjecData----');
                                                    print(responsePatchFavoriteProjectData);
                                                    print(student.id);

                                                    getProjects(user.token!, Language);
                                                  },
                                            child: Icon(
                                              el.isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                                              size: 28,
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
                                              color: colorApp.colorCreate,
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
                                            Language.Time +
                                                ': ${el.projectScopeFlag == 0 ? Language.Time_1 : el.projectScopeFlag == 1 ? Language.Time_2 : el.projectScopeFlag == 2 ? Language.Time_3 : Language.Time_4}, ${el.numberOfStudents} ' +
                                                Language.StudentNeed,
                                            style: TextStyle(
                                              color: colorApp.colorText,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 15,
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
                                          Icon(
                                            Icons.format_indent_increase_rounded,
                                            size: 22,
                                            color: colorApp.colorIcon,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            Language.Proposals + ': ${el.countProposals}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: colorApp.colorText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      })
                    ],
                  ),
      ),
    );
  }
}
