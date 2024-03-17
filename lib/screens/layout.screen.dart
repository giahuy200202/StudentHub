import 'package:flutter/material.dart';
import 'package:studenthub/providers/options_provider.dart';
import 'package:studenthub/screens/authentication/signup_step1.screen.dart';
import 'package:studenthub/screens/authentication/signup_step2.screen.dart';
import 'package:studenthub/screens/homepage/homepage.screen.dart';
import 'package:studenthub/screens/authentication/login.screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/screens/post_project/project_post_step1.screen.dart';
import 'package:studenthub/screens/post_project/project_post_step2.screen.dart';
import 'package:studenthub/screens/post_project/project_post_step3.screen.dart';
import 'package:studenthub/screens/post_project/project_post_step4.screen.dart';
import 'package:studenthub/screens/dashboard/dashboard.screen.dart';
import 'package:studenthub/screens/profile/profile_input.screen.dart';
import 'package:studenthub/screens/profile/switch_account.screen.dart';
import 'package:studenthub/screens/welcome/welcome.screen.dart';
import 'package:studenthub/widgets/navbar/top_navbar.widget.dart';
import 'package:studenthub/screens/profile/profileInput_2.sceen.dart';
import 'package:studenthub/screens/profile/profileinputStudent_step1.screen.dart';
import 'package:studenthub/screens/profile/profileinputStudent_step3.screen.dart';

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

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

    if (index == 0) {
      ref.read(optionsProvider.notifier).setWidgetOption('');
    } else if (index == 1) {
      ref.read(optionsProvider.notifier).setWidgetOption('Dashboard');
    } else if (index == 2) {
      ref.read(optionsProvider.notifier).setWidgetOption('');
    } else if (index == 3) {
      ref.read(optionsProvider.notifier).setWidgetOption('');
    }
  }

  Widget getCurrentScreen(String widgetOption) {
    if (widgetOption == '' || widgetOption == 'Homepage') {
      return const HomepageScreen();
    } else if (widgetOption == 'Login') {
      return const LoginScreen();
    } else if (widgetOption == 'SignupStep1') {
      return const SignupStep1Screen();
    } else if (widgetOption == 'SignupStep2') {
      return const SignupStep2Screen();
    } else if (widgetOption == 'SwitchAccount') {
      return const SwitchAccountScreen();
    } else if (widgetOption == 'ProfileInput') {
      return const ProfileInputScreen();
    } else if (widgetOption == 'Welcome') {
      return const WelcomeScreen();
    } else if (widgetOption == 'ViewProfile') {
      return const ViewProfileInputScreen();
    } else if (widgetOption == 'ViewProfileStudent') {
      return const ProfileIputStudentScreen();
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
    }

    // if (_selectedPageIndex == 0) {
    //   return const HomepageScreen();
    // } else if (_selectedPageIndex == 1) {
    //   if (widgetOption == 'Dashboard') {
    //     return const DashboardScreen();
    //   } else if (widgetOption == 'ProjectPostStep1') {
    //     return const ProjectPostStep1Screen();
    //   }
    // } else if (_selectedPageIndex == 2) {
    //   return const HomepageScreen();
    // } else if (_selectedPageIndex == 3) {
    //   return const HomepageScreen();
    // }

    return const HomepageScreen();
  }

  @override
  Widget build(BuildContext context) {
    final options = ref.watch(optionsProvider);

    Widget currentScreen = getCurrentScreen(options[Option.widgetOption]!);

    return Scaffold(
        appBar: PreferredSize(
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
        bottomNavigationBar: !isLogin ||
                options[Option.widgetOption] == 'Dashboard'
            ? BottomNavigationBar(
                onTap: _selectPage,
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
                    label: 'Alert',
                  ),
                ],
              )
            : null);
  }
}
