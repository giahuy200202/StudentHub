import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/profile_company.widget.dart';
import 'package:studenthub/widgets/welcome_company.widget.dart';
import 'package:studenthub/widgets/dashboard_company.widget.dart';

class welcome_company extends ConsumerWidget {
  const welcome_company({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const WelcomeCompanyWidget();
  }
}

class profile_company extends ConsumerWidget {
  const profile_company({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProfileCompanyWidget();
  }
}

class Dashboard_company extends ConsumerWidget {
  const Dashboard_company({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DashboardCompanyWidget();
  }
}
