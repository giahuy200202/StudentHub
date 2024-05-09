import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/widgets/dashboard/all_projects.widget.dart';
import 'package:studenthub/widgets/dashboard/all_projects_student.widget.dart';
import 'package:studenthub/widgets/dashboard/archieved.widget.dart';
import 'package:studenthub/widgets/dashboard/archieved_student.widget.dart';
import 'package:studenthub/widgets/dashboard/working.widget.dart';
import 'package:studenthub/widgets/dashboard/working_student.widget.dart';
import '../../providers/options.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int tabWidget = 1;

  void setTabWidget(int index) {
    setState(() {
      tabWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    var colorApp = ref.watch(colorProvider);

    Widget dashboardCompany = Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Your projects',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: colorApp.colorTitle,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 43,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep1', user.role!);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero, // and this
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: colorApp.colorBlackWhite,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 22,
                            color: colorApp.colorWhiteBlack,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Post a project',
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
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorApp.colorBlackWhite as Color,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "All projects",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorTitle,
                          fontWeight: tabWidget == 1 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
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
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorApp.colorBlackWhite as Color,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Working",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorBlackWhite,
                          fontWeight: tabWidget == 2 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
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
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorApp.colorBlackWhite as Color,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Archieved",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorBlackWhite,
                          fontWeight: tabWidget == 3 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              tabWidget == 1
                  ? AllProjectsWidget()
                  : tabWidget == 2
                      ? WorkingWidget()
                      : ArchievedWidget()
            ],
          ),
        ),
      ),
    );

    Widget dashboardStudent = Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     'Your projects',
              //     textAlign: TextAlign.left,
              //     style: TextStyle(
              //       fontSize: 22,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorApp.colorBlackWhite as Color,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "All projects",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorTitle,
                          fontWeight: tabWidget == 1 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
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
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorApp.colorTitle as Color,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Working",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorTitle,
                          fontWeight: tabWidget == 2 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
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
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorApp.colorBlackWhite as Color,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Archieved",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorTitle,
                          fontWeight: tabWidget == 3 ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              tabWidget == 1
                  ? AllProjectsStudentWidget()
                  : tabWidget == 2
                      ? WorkingStudentWidget()
                      : ArchievedStudentWidget()
            ],
          ),
        ),
      ),
    );

    return user.role == "1" ? dashboardCompany : dashboardStudent;
  }
}
