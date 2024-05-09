import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/language/language.provider.dart';
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
    var Language = ref.watch(LanguageProvider);
    final tmp = ref.read(colorProvider.notifier);
    final lan = ref.read(LanguageProvider.notifier);
    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // SizedBox(
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //         color: colorApp.colorBackgroundColor,
              //         borderRadius: BorderRadius.circular(8),
              //         border: Border.all(
              //           color: colorApp.colorBorderSide as Color,
              //         )),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SizedBox(width: 10),
              //         Text(
              //           Language.language,
              //           style: TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.bold,
              //             color: colorApp.colorTitle,
              //           ),
              //         ),
              //         const Spacer(),
              //         Switch(
              //           value: lan.LanguageChange,
              //           onChanged: (enbled) {
              //             print(enbled);
              //             if (enbled) {
              //               setState(() {
              //                 lan.setVNLanguage();
              //               });
              //             } else {
              //               setState(() {
              //                 lan.setEngLanguage();
              //               });
              //             }
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
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
                      SizedBox(width: 10),
                      Text(
                        Language.Dark_mode,
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
                          print(tmp.isDarkMode);
                          if (enbled) {
                            setState(() {
                              tmp.setDarkMode();
                            });
                          } else {
                            setState(() {
                              tmp.setLightMode();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
