import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/switch_account.provider.dart';

class TopNavbar extends ConsumerWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final student = ref.watch(studentProvider);
    final company = ref.watch(companyProvider);
    final switchAccount = ref.watch(switchAccountProvider);
    final options = ref.watch(optionsProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15, top: 50, bottom: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                if (user.token != null && user.token != '') {
                  if (switchAccount == '0') {
                    if (student.id != null && student.id != 0) {
                      ref.read(optionsProvider.notifier).setWidgetOption(
                            'Projects',
                            user.role!,
                          );
                    } else {
                      ref.read(optionsProvider.notifier).setWidgetOption(
                            'ProfileInputStudent',
                            user.role!,
                          );
                    }
                  } else {
                    if (company.id != null && company.id != 0) {
                      ref.read(optionsProvider.notifier).setWidgetOption(
                            'Dashboard',
                            user.role!,
                          );
                    } else {
                      ref.read(optionsProvider.notifier).setWidgetOption(
                            'ProfileInput',
                            user.role!,
                          );
                    }
                  }
                } else {
                  ref.read(optionsProvider.notifier).setWidgetOption(
                        'Homepage',
                        user.role!,
                      );
                }
              },
              child: Text(
                options[Option.widgetOption]!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              ref.read(optionsProvider.notifier).setWidgetOption('SwitchAccount', user.role!);
            },
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
              // onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
