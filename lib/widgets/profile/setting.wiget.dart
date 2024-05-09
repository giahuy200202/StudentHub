import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/language/language.provider.dart';

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
    final tmp = ref.read(LanguageProvider.notifier);
    var Language = ref.watch(LanguageProvider);
    return Scaffold(
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
                        Text(
                          Language.language,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: tmp.LanguageChange,
                          onChanged: (enbled) {
                            print(enbled);
                            if (enbled) {
                              setState(() {
                                tmp.setVNLanguage();
                              });
                            } else {
                              setState(() {
                                tmp.setEngLanguage();
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ))
                ]))));
  }
}
