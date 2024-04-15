import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class SettingWidget extends ConsumerStatefulWidget {
  const SettingWidget({super.key});

  @override
  ConsumerState<SettingWidget> createState() {
    return _SettingWidget();
  }
}

class _SettingWidget extends ConsumerState<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 30),
                  SizedBox(
                      child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all()),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        const Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: theme.isDarkMode,
                          onChanged: (enbled) {
                            if (enbled) {
                              theme.setDarkTheme();
                            } else {
                              theme.setLightTheme();
                            }
                          },
                        ),
                      ],
                    ),
                  ))
                ]))));
  }
}
