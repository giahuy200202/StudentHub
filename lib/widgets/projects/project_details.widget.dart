import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:toastification/toastification.dart';
import '../../providers/projects/project_posting.provider.dart';
// import '../../providers/options_provider.dart';

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
  final dynamic proposals;

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
    required this.proposals,
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
        proposals = json['proposals'];

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
      'proposals': proposals,
    };
  }
}

class ProjectDetailsWidget extends ConsumerStatefulWidget {
  const ProjectDetailsWidget({super.key});

  @override
  ConsumerState<ProjectDetailsWidget> createState() {
    return _ProjectDetailsWidgetState();
  }
}

class _ProjectDetailsWidgetState extends ConsumerState<ProjectDetailsWidget> {
  var descriptionController = TextEditingController();
  bool enable = false;
  Project listProjects = Project(
    projectId: '',
    title: '',
    createTime: '',
    projectScopeFlag: 0,
    numberOfStudents: 0,
    description: '',
    countProposals: 0,
    countMessages: 0,
    countHired: 0,
    proposals: [],
  );

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

  void getProjects(token, studentId, projectId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetDetailedProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project/$projectId');

    final responseDetailedProjects = await http.get(
      urlGetDetailedProjects,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseDetailedProjectsData = json.decode(responseDetailedProjects.body);
    print('----responseDetailedProjectsData----');
    print(responseDetailedProjectsData);

    Project listProjectsGetFromRes = Project(
      projectId: '',
      title: '',
      createTime: '',
      projectScopeFlag: 0,
      numberOfStudents: 0,
      description: '',
      countProposals: 0,
      countMessages: 0,
      countHired: 0,
      proposals: [],
    );
    if (responseDetailedProjectsData['result'] != null) {
      listProjectsGetFromRes = Project(
        projectId: responseDetailedProjectsData['result']['id'].toString(),
        title: responseDetailedProjectsData['result']['title'],
        createTime: 'Created at ${DateFormat("dd/MM/yyyy | HH:mm").format(
              DateTime.parse(responseDetailedProjectsData['result']['createdAt']),
            ).toString()}',
        projectScopeFlag: responseDetailedProjectsData['result']['projectScopeFlag'],
        numberOfStudents: responseDetailedProjectsData['result']['numberOfStudents'],
        description: responseDetailedProjectsData['result']['description'],
        countProposals: responseDetailedProjectsData['result']['countProposals'],
        countMessages: responseDetailedProjectsData['result']['countMessages'],
        countHired: responseDetailedProjectsData['result']['countHired'],
        proposals: [...responseDetailedProjectsData['result']['proposals']],
      );
    }

    setState(() {
      listProjects = listProjectsGetFromRes;
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    final student = ref.read(studentProvider);
    final projectId = ref.read(projectIdProvider);
    getProjects(user.token!, student.id, projectId);
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectPosting = ref.watch(projectPostingProvider);
    final user = ref.watch(userProvider);
    final projectId = ref.watch(projectIdProvider);
    final student = ref.watch(studentProvider);

    return SingleChildScrollView(
      child: isFetchingData
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 420),
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Project details',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                                      listProjects.title,
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
                                  onTap: user.role == '0'
                                      ? () async {
                                          final urlFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/${student.id}?');

                                          final responsePatchFavoriteProject = await http.patch(
                                            urlFavoriteProjects,
                                            headers: {
                                              'Content-Type': 'application/json',
                                              'Authorization': 'Bearer ${user.token!}',
                                            },
                                            body: json.encode({
                                              'projectId': listProjects.projectId,
                                              'disableFlag': 0,
                                            }),
                                          );

                                          final responsePatchFavoriteProjectData = json.decode(responsePatchFavoriteProject.body);

                                          print('----responsePatchFavoriteProjecData----');
                                          print(responsePatchFavoriteProjectData);

                                          ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                                          showSuccessToast('Success', 'Project added to favorites');
                                        }
                                      : null,
                                  child: const Icon(Icons.favorite_outline),
                                ),
                              ],
                            ),
                            const SizedBox(height: 1),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 340,
                                child: Text(
                                  listProjects.createTime,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 94, 94, 94),
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
                                  color: Colors.black, //                   <--- border color
                                  width: 0.3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                listProjects.description,
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
                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.alarm,
                                      size: 40,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Project scope',
                                          style: TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          listProjects.projectScopeFlag == 0
                                              ? 'Less than 1 month'
                                              : listProjects.projectScopeFlag == 1
                                                  ? ' 1-3 months'
                                                  : listProjects.projectScopeFlag == 2
                                                      ? '3-6 months'
                                                      : 'More than 6 months',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.group,
                                      size: 40,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Student required',
                                          style: TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '${listProjects.numberOfStudents} students',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 46,
                          width: 175,
                          child: ElevatedButton(
                            onPressed: user.role == '0'
                                ? () async {
                                    // final urlFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/${student.id}?');

                                    // final responsePatchFavoriteProject = await http.patch(
                                    //   urlFavoriteProjects,
                                    //   headers: {
                                    //     'Content-Type': 'application/json',
                                    //     'Authorization': 'Bearer ${user.token!}',
                                    //   },
                                    //   body: json.encode({
                                    //     'projectId': listProjects.projectId,
                                    //     'disableFlag': 0,
                                    //   }),
                                    // );

                                    // final responsePatchFavoriteProjectData = json.decode(responsePatchFavoriteProject.body);

                                    // print('----responsePatchFavoriteProjecData----');
                                    // print(responsePatchFavoriteProjectData);

                                    // showSuccessToast('Success', 'Project added to favorites');
                                    print(projectId);

                                    if (projectId == '' || projectId != listProjects.projectId) {
                                      ref.read(projectIdProvider.notifier).setProjectId(listProjects.projectId);
                                    }

                                    ref.read(optionsProvider.notifier).setWidgetOption('SubmitProposal', user.role!);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Apply now',
                              style: TextStyle(
                                fontSize: 16,
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
                            onPressed: user.role == '0'
                                ? () async {
                                    final urlFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/${student.id}?');

                                    final responsePatchFavoriteProject = await http.patch(
                                      urlFavoriteProjects,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${user.token!}',
                                      },
                                      body: json.encode({
                                        'projectId': listProjects.projectId,
                                        'disableFlag': 0,
                                      }),
                                    );

                                    final responsePatchFavoriteProjectData = json.decode(responsePatchFavoriteProject.body);

                                    print('----responsePatchFavoriteProjecData----');
                                    print(responsePatchFavoriteProjectData);

                                    ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                                    showSuccessToast('Success', 'Project added to favorites');
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
