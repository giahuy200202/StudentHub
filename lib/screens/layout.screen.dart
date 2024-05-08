import 'package:flutter/material.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/screens/authentication/change_password.screen.dart';
import 'package:studenthub/screens/authentication/forgot_password.screen.dart';
import 'package:studenthub/screens/authentication/signup_step1.screen.dart';
import 'package:studenthub/screens/authentication/signup_step2.screen.dart';
import 'package:studenthub/screens/dashboard/send_hire_offer.screen.dart';
import 'package:studenthub/screens/homepage/homepage.screen.dart';
import 'package:studenthub/screens/authentication/login.screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/screens/post_project/project_post_step1.screen.dart';
import 'package:studenthub/screens/post_project/project_post_step2.screen.dart';
import 'package:studenthub/screens/post_project/project_post_step3.screen.dart';
import 'package:studenthub/screens/post_project/project_post_step4.screen.dart';
import 'package:studenthub/screens/dashboard/dashboard.screen.dart';
import 'package:studenthub/screens/profile/profile_input.screen.dart';
import 'package:studenthub/screens/profile/profileinputStudent_step2.screen.dart';
import 'package:studenthub/screens/profile/switch_account.screen.dart';
import 'package:studenthub/screens/projects/project_details.screen.dart';
import 'package:studenthub/screens/projects/project_search.screen.dart';
import 'package:studenthub/screens/projects/projects.screen.dart';
import 'package:studenthub/screens/projects/saved_projects.screen.dart';
import 'package:studenthub/screens/projects/submit_proposal.screen.dart';
import 'package:studenthub/screens/welcome/welcome.screen.dart';
import 'package:studenthub/widgets/navbar/top_navbar.widget.dart';
import 'package:studenthub/screens/profile/profileInput_2.sceen.dart';
import 'package:studenthub/screens/profile/profileinputStudent_step1.screen.dart';
import 'package:studenthub/screens/profile/profileinputStudent_step3.screen.dart';
import 'package:studenthub/screens/message/message.screen.dart';
import 'package:studenthub/screens/chat/message_details.screen.dart';
import 'package:studenthub/widgets/message/videocalll.widget.dart';
import 'package:studenthub/screens/alerts/alerts.screen.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  const LayoutScreen({super.key});

  @override
  ConsumerState<LayoutScreen> createState() {
    return _LayoutScreenState();
  }
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  int _selectedPageIndex = 1;
  bool isLogin = true;

  // void _selectPage(int index) {
  //   setState(() {
  //     _selectedPageIndex = index;
  //   });

  //   if (index == 0) {
  //     ref.read(optionsProvider.notifier).setWidgetOption('Projects');
  //   } else if (index == 1) {
  //     ref.read(optionsProvider.notifier).setWidgetOption('Dashboard');
  //   } else if (index == 2) {
  //     ref.read(optionsProvider.notifier).setWidgetOption('Message');
  //   } else if (index == 3) {
  //     ref.read(optionsProvider.notifier).setWidgetOption('');
  //   }
  // }

  Widget getCurrentScreen(String widgetOption) {
    if (widgetOption == '' || widgetOption == 'Homepage') {
      return const HomepageScreen();
    } else if (widgetOption == 'Login') {
      return const LoginScreen();
    } else if (widgetOption == 'ForgotPassword') {
      return const ForgotPasswordScreen();
    } else if (widgetOption == 'SignupStep1') {
      return const SignupStep1Screen();
    } else if (widgetOption == 'SignupStep2') {
      return const SignupStep2Screen();
    } else if (widgetOption == 'SwitchAccount') {
      return const SwitchAccountScreen();
    } else if (widgetOption == 'ProfileInput') {
      return const ProfileInputScreen();
    } else if (widgetOption == 'ProfileInputStudent') {
      return const ProfileIputStudentScreen();
    } else if (widgetOption == 'ProfileInputStudentStep2') {
      return const ProfileIputStudentStep2Screen();
    } else if (widgetOption == 'ProfileInputStudentStep3') {
      return const ProfileIputStudentStep3Screen();
    } else if (widgetOption == 'Welcome') {
      return const WelcomeScreen();
    } else if (widgetOption == 'ViewProfile') {
      return const ViewProfileInputScreen();
    } else if (widgetOption == 'ViewProfileStudent') {
      return const ProfileIputStudentScreen();
    } else if (widgetOption == 'ChangePassword') {
      return const ChangePasswordScreen();
    } else if (widgetOption == 'Dashboard') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const DashboardScreen();
    } else if (widgetOption == 'ProjectPostStep1') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const ProjectPostStep1Screen();
    } else if (widgetOption == 'ProjectPostStep2') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const ProjectPostStep2Screen();
    } else if (widgetOption == 'ProjectPostStep3') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const ProjectPostStep3Screen();
    } else if (widgetOption == 'ProjectPostStep4') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const ProjectPostStep4Screen();
    } else if (widgetOption == 'Projects') {
      setState(() {
        _selectedPageIndex = 0;
      });
      return const ProjectScreen();
    } else if (widgetOption == 'ProjectDetails') {
      setState(() {
        _selectedPageIndex = 0;
      });
      return const ProjectDetailsScreen();
    } else if (widgetOption == 'SavedProjects') {
      setState(() {
        _selectedPageIndex = 0;
      });
      return const SavedProjectsScreen();
    } else if (widgetOption == 'SendHireOffer') {
      setState(() {
        _selectedPageIndex = 0;
      });
      return const SendHireOfferScreen();
    } else if (widgetOption == 'Message') {
      setState(() {
        _selectedPageIndex = 2;
      });
      return const MessageScreen();
    } else if (widgetOption == 'MessageDetails') {
      setState(() {
        _selectedPageIndex = 2;
      });
      return const MessageDetailsScreen();
    } else if (widgetOption == 'SubmitProposal') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const SubmitProposalScreen();
    } else if (widgetOption == 'ProjectSearch') {
      setState(() {
        _selectedPageIndex = 0;
      });
      return const ProjectSearchScreen();
    } else if (widgetOption == 'Videocall') {
      setState(() {
        _selectedPageIndex = 2;
      });
      return const VideocallWidget();
    } else if (widgetOption == 'Notification') {
      setState(() {
        _selectedPageIndex = 3;
      });
      return const AlertsScreen();
    }

    return const HomepageScreen();
  }

  @override
  Widget build(BuildContext context) {
    final options = ref.watch(optionsProvider);
    final user = ref.watch(userProvider);

    // Widget currentScreen;
    // currentScreen = user.role == ''
    //     ? const LoginScreen()
    //     : getCurrentScreen(options[Option.widgetOption]!);

    // if (options[Option.widgetOption] == '' ||
    //     options[Option.widgetOption] == 'Homepage') {
    //   currentScreen = const HomepageScreen();
    // }

    Widget currentScreen = getCurrentScreen(options[Option.widgetOption]!);

    return Scaffold(
        appBar: options[Option.widgetOption] == "ProjectSearch" ||
                options[Option.widgetOption] == "SavedProjects" ||
                options[Option.widgetOption] == "ProjectDetails" ||
                options[Option.widgetOption] == "SubmitProposal" ||
                options[Option.widgetOption] == "Videocall" ||
                options[Option.widgetOption] == "MessageDetails" ||
                options[Option.widgetOption] == "SendHireOffer" ||
                options[Option.widgetOption] == "ProjectPostStep4" ||
                options[Option.widgetOption] == "ProjectPostStep3" ||
                options[Option.widgetOption] == "ProjectPostStep2" ||
                options[Option.widgetOption] == "ProjectPostStep1" ||
                options[Option.widgetOption] == "ForgotPassword" ||
                options[Option.widgetOption] == "ChangePassword" ||
                options[Option.widgetOption] == "" ||
                options[Option.widgetOption] == "Homepage" ||
                options[Option.widgetOption] == "Welcome" ||
                options[Option.widgetOption] == "Login" ||
                options[Option.widgetOption] == "SignupStep1" ||
                options[Option.widgetOption] == "SignupStep2"
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Color.fromARGB(255, 73, 80, 87)],
                    ),
                  ),
                  child: const TopNavbar(),
                ),
              ),
        body: currentScreen,
        bottomNavigationBar: options[Option.widgetOption] == 'Projects' || options[Option.widgetOption] == 'Dashboard' || options[Option.widgetOption] == 'Message' || options[Option.widgetOption] == 'Notification'
            ? BottomNavigationBar(
                onTap: (int index) {
                  setState(() {
                    _selectedPageIndex = index;
                  });

                  if (index == 0) {
                    ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                  } else if (index == 1) {
                    ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
                  } else if (index == 2) {
                    ref.read(optionsProvider.notifier).setWidgetOption('Message', user.role!);
                  } else if (index == 3) {
                    ref.read(optionsProvider.notifier).setWidgetOption('Notification', user.role!);
                  }
                },
                currentIndex: _selectedPageIndex,
                backgroundColor: Colors.black,
                elevation: 0.0,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.list_alt_outlined, size: 30),
                    ),
                    label: 'Projects',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.dashboard_customize_outlined, size: 30),
                    ),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.message_outlined, size: 30),
                    ),
                    label: 'Message',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.notifications_active, size: 30),
                    ),
                    label: 'Notification',
                  ),
                ],
              )
            : null);
  }
}
