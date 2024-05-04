import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/widgets/dashboard/archieved.widget.dart';
import 'package:studenthub/widgets/dashboard/detail.widget.dart';
import 'package:studenthub/widgets/dashboard/hired.widget.dart';
import 'package:studenthub/widgets/dashboard/message.widget.dart';
import 'package:studenthub/widgets/dashboard/proposals.widget.dart';
import 'package:studenthub/widgets/dashboard/working.widget.dart';
import 'package:toastification/toastification.dart';
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

class SendHireOfferScreen extends ConsumerStatefulWidget {
  const SendHireOfferScreen({super.key});

  @override
  ConsumerState<SendHireOfferScreen> createState() {
    return _SendHireOfferScreenState();
  }
}

class _SendHireOfferScreenState extends ConsumerState<SendHireOfferScreen> {
  int tabWidget = 1;

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

  void setTabWidget(int index) {
    setState(() {
      tabWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      listProjects.title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 1
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Proposals",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 1 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 2
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Detail",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 2 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(3);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 3
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 3 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(4);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 4
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Hired",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 4 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              tabWidget == 1
                  ? const ProposalsWidget()
                  : tabWidget == 2
                      ? const DetailWidget()
                      : tabWidget == 3
                          ? const MessageWidget()
                          : const HiredWidget()
            ],
          ),
        ),
      ),
    );
  }
}
