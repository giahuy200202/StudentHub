import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/login.widget.dart';
import 'package:studenthub/widgets/profile_company.widget.dart';

class ProfileInputScreen extends ConsumerWidget {
  const ProfileInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProfileCompanyWidget();
  }
}
