import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:toastification/toastification.dart';
import '../../providers/projects/project_posting.provider.dart';
import '../../providers/options.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

import 'package:http/http.dart' as http;

class ProjectPostStep4Widget extends ConsumerStatefulWidget {
  const ProjectPostStep4Widget({super.key});

  @override
  ConsumerState<ProjectPostStep4Widget> createState() {
    return _ProjectPostStep4WidgetState();
  }
}

class _ProjectPostStep4WidgetState extends ConsumerState<ProjectPostStep4Widget> {
  var descriptionController = TextEditingController();
  bool enable = false;
  bool isFetching = false;

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

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectPosting = ref.watch(projectPostingProvider);
    final user = ref.watch(userProvider);
    final company = ref.watch(companyProvider);
    var colorApp = ref.watch(colorProvider);

    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep3', user.role!);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Project details',
                    style: TextStyle(
                      fontSize: 27,
                      color: colorApp.colorTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reviewing the project before posting ensures accuracy, completeness, and clarity, setting the stage for successful collaboration.',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorApp.colorText,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 2.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: 1,
                        backgroundColor: colorApp.colorClip,
                        valueColor: AlwaysStoppedAnimation<Color>(colorApp.colorBlackWhite as Color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: colorApp.colorBackgroundColor,
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
                                  projectPosting.title!,
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
                              onTap: () {},
                              child: Icon(
                                Icons.more_horiz,
                                color: colorApp.colorIcon,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 340,
                            child: Text(
                              'Created 1 minute ago',
                              style: TextStyle(
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
                              color: colorApp.colorBorderSide as Color, //                   <--- border color
                              width: 0.3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            projectPosting.description!,
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
                              color: colorApp.colorBorderSide as Color, //                   <--- border color
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
                                Icon(
                                  Icons.alarm,
                                  size: 40,
                                  color: colorApp.colorIcon,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Project scope',
                                      style: TextStyle(
                                        color: colorApp.colorTitle,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      projectPosting.scope == 0
                                          ? 'Less than 1 month'
                                          : projectPosting.scope == 1
                                              ? '1 to 3 months'
                                              : projectPosting.scope == 2
                                                  ? '3 to 6 months'
                                                  : 'More than 6 months',
                                      style: TextStyle(
                                        color: colorApp.colorText,
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
                                Icon(
                                  Icons.group,
                                  size: 40,
                                  color: colorApp.colorIcon,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Student required',
                                      style: TextStyle(
                                        color: colorApp.colorTitle,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '${projectPosting.numOfStudents} students',
                                      style: TextStyle(
                                        color: colorApp.colorText,
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
                SizedBox(
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: isFetching
                        ? null
                        : () async {
                            setState(() {
                              isFetching = true;
                            });

                            final urlPostprojects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project');

                            final responsePostProjects = await http.post(
                              urlPostprojects,
                              headers: {
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${user.token}',
                              },
                              body: json.encode({
                                'companyId': company.id,
                                'projectScopeFlag': projectPosting.scope,
                                'title': projectPosting.title,
                                'numberOfStudents': int.parse(projectPosting.numOfStudents!),
                                'description': projectPosting.description,
                                "typeFlag": 0,
                              }),
                            );

                            final responsePostProjectsData = json.decode(responsePostProjects.body);
                            print('----responsePostProjectsData----');
                            print(responsePostProjectsData);

                            if (responsePostProjectsData.containsKey('errorDetails')) {
                              if (responsePostProjectsData['errorDetails'] is String) {
                                showErrorToast('Error', responsePostProjectsData['errorDetails']);
                              } else {
                                showErrorToast('Error', responsePostProjectsData['errorDetails'][0]);
                              }
                              setState(() {
                                isFetching = false;
                              });
                            } else {
                              showSuccessToast('Success', 'Create new project successfully');
                              ref.read(projectPostingProvider.notifier).setTitle('');
                              ref.read(projectPostingProvider.notifier).setScope(-1);
                              ref.read(projectPostingProvider.notifier).setNumOfStudents('');
                              ref.read(projectPostingProvider.notifier).setDescription('');

                              setState(() {
                                isFetching = false;
                              });

                              ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.zero, // and this
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.grey),
                      ),
                      backgroundColor: colorApp.colorBlackWhite,
                    ),
                    child: isFetching
                        ? const SizedBox(
                            height: 17,
                            width: 17,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Post project',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: colorApp.colorWhiteBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
