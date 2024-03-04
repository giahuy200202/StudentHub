import 'package:flutter/material.dart';
import 'package:studenthub/providers/options_provider.dart';
import 'package:studenthub/screens/homepage.screen.dart';
import 'package:studenthub/screens/login.screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/screens/profile.screen.dart';
import 'package:studenthub/screens/switch_account.screen.dart';
import 'package:studenthub/widgets/profile_company.widget.dart';
import 'package:studenthub/widgets/signup_step1.widget.dart';
import 'package:studenthub/widgets/signup_step2.widget.dart';
import 'package:studenthub/widgets/top_navbar.widget.dart';
import 'package:studenthub/widgets/welcome_company.widget.dart';
import 'package:studenthub/widgets/profile_company.widget.dart';

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
    ref.read(optionsProvider.notifier).setWidgetOption('');
  }

  Widget getCurrentScreen(String widgetOption) {
    if (widgetOption == '') {
      return const HomepageScreen();
    } else if (widgetOption == 'Login') {
      return const LoginScreen();
    } else if (widgetOption == 'SignupStep1') {
      return const SignupStep1();
    } else if (widgetOption == 'SignupStep2') {
      return const SignupStep2();
    }
    if (_selectedPageIndex == 0) {
      return const HomepageScreen();
    } else if (_selectedPageIndex == 1 || widgetOption == 'Dashboard') {
      setState(() {
        _selectedPageIndex = 1;
      });
      return const HomepageScreen();
    } else if (_selectedPageIndex == 2) {
      return const HomepageScreen();
    } else if (_selectedPageIndex == 3) {
      return const HomepageScreen();
    }

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
      body: const SwitchAccountScreen(),
      bottomNavigationBar: !isLogin ||
              options[Option.widgetOption] != 'Dashboard'
          ? null
          : BottomNavigationBar(
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
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.list_alt_outlined, size: 30),
                  ),
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.dashboard_customize_outlined, size: 30),
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.message_outlined, size: 30),
                  ),
                  label: 'Message',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.notifications_active, size: 30),
                  ),
                  label: 'Alert',
                ),
              ],
            ),
    );
  }
}
