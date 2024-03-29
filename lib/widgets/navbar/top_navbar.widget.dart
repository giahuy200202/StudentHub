import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication_provider.dart';
import 'package:studenthub/providers/options_provider.dart';

class TopNavbar extends ConsumerWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15, top: 50, bottom: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                ref
                    .read(optionsProvider.notifier)
                    .setWidgetOption('Homepage', user.role!);
              },
              child: const Text(
                'StudentHub',
                style: TextStyle(
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
              ref
                  .read(optionsProvider.notifier)
                  .setWidgetOption('SwitchAccount', user.role!);
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
