import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:toastification/toastification.dart';

import '../../providers/options.provider.dart';

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

  Project({
    required this.id,
    required this.title,
    required this.createTime,
    required this.projectScopeFlag,
    required this.numberOfStudents,
    required this.description,
    required this.countProposals,
  });

  Project.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'],
        createTime = json['createdAt'],
        projectScopeFlag = json['projectScopeFlag'],
        numberOfStudents = json['numberOfStudents'],
        description = json['description'],
        countProposals = json['countProposals'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createTime,
      'projectScopeFlag': projectScopeFlag,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'countProposals': countProposals,
    };
  }
}

class SavedProjectsWidget extends ConsumerStatefulWidget {
  const SavedProjectsWidget({super.key});

  @override
  ConsumerState<SavedProjectsWidget> createState() {
    return _SavedProjectsWidgetState();
  }
}

class _SavedProjectsWidgetState extends ConsumerState<SavedProjectsWidget> {
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

  void getProjects(token, studentId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/$studentId');

    final responseFavoriteProjects = await http.get(
      urlGetFavoriteProjects,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseFavoriteProjectsData = json.decode(responseFavoriteProjects.body);
    print('----responseFavoriteProjectsData----');
    print(responseFavoriteProjectsData['result']);

    List<Project> listProjectsGetFromRes = [];
    if (responseFavoriteProjectsData['result'] != null) {
      for (var item in responseFavoriteProjectsData['result']) {
        listProjectsGetFromRes.add(Project(
          id: item['project']['id'].toString(),
          title: item['project']['title'],
          createTime: 'Created at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['project']['createdAt']),
              ).toString()}',
          projectScopeFlag: item['project']['projectScopeFlag'],
          numberOfStudents: item['project']['numberOfStudents'],
          description: item['project']['description'],
          countProposals: item['project']['countProposals'],
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
    final student = ref.read(studentProvider);
    getProjects(user.token!, student.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final student = ref.watch(studentProvider);
    final projectId = ref.watch(projectIdProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Saved projects',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 650,
                child: SingleChildScrollView(
                  child: isFetchingData
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 270),
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
                          ? const Column(
                              children: [
                                Text(
                                  'Empty',
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
                                          if (projectId == '' || projectId != el.id) {
                                            ref.read(projectIdProvider.notifier).setProjectId(el.id.toString());
                                          }
                                          ref.read(optionsProvider.notifier).setWidgetOption('ProjectDetails', user.role!);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.white,
                                            // border: Border.all(color: Colors.grey),
                                            color: Colors.white,
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
                                                          style: const TextStyle(
                                                            color: Colors.black,
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
                                                              final urlFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/${student.id}?');

                                                              final responsePatchFavoriteProject = await http.patch(
                                                                urlFavoriteProjects,
                                                                headers: {
                                                                  'Content-Type': 'application/json',
                                                                  'Authorization': 'Bearer ${user.token!}',
                                                                },
                                                                body: json.encode({
                                                                  'id': el.id,
                                                                  'disableFlag': 1,
                                                                }),
                                                              );

                                                              final responsePatchFavoriteProjectData = json.decode(responsePatchFavoriteProject.body);

                                                              print('----responsePatchFavoriteProjecData----');
                                                              print(responsePatchFavoriteProjectData);

                                                              getProjects(user.token!, student.id);
                                                            },
                                                      child: const Icon(
                                                        Icons.favorite_rounded,
                                                        size: 28,
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
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(255, 94, 94, 94),
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
                                                      'Time: ${el.projectScopeFlag == 0 ? 'Less than 1 month' : el.projectScopeFlag == 1 ? ' 1-3 months' : el.projectScopeFlag == 2 ? '3-6 months' : 'More than 6 months'}, ${el.numberOfStudents} students needed',
                                                      style: const TextStyle(
                                                        color: Colors.black,
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
                                                      color: Colors.black, //                   <--- border color
                                                      width: 0.3,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    el.description,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
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
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.format_indent_increase_rounded,
                                                      size: 22,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      'Proposals: ${el.countProposals}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
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
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
