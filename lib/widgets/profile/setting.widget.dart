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
    var colorApp = ref.watch(colorProvider);
    final tmp = ref.read(colorProvider.notifier);
    return Scaffold(
        backgroundColor: colorApp.colorBackgroundColor,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 30),
                  SizedBox(
                      child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: colorApp.colorBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colorApp.colorBorderSide as Color,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorApp.colorTitle,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: tmp.isDarkMode,
                          onChanged: (enbled) {
                            print(enbled);
                            if (enbled) {
                              tmp.setDarkMode();
                            } else {
                              tmp.setLightMode();
                            }
                          },
                        ),
                      ],
                    ),
                  ))
                ]))));
  }
}
