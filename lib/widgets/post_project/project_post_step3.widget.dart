import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import '../../providers/projects/project_posting.provider.dart';
import '../../providers/options.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';

class ProjectPostStep3Widget extends ConsumerStatefulWidget {
  const ProjectPostStep3Widget({super.key});

  @override
  ConsumerState<ProjectPostStep3Widget> createState() {
    return _ProjectPostStep3WidgetState();
  }
}

class _ProjectPostStep3WidgetState extends ConsumerState<ProjectPostStep3Widget> {
  var descriptionController = TextEditingController();
  bool enable = false;
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    var colorApp = ref.watch(colorProvider);

    var Language = ref.watch(LanguageProvider);
    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep2', user.role!);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Language.TitlePost_3,
                    style: TextStyle(
                      fontSize: 27,
                      color: colorApp.colorTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Language.DescriptionPost_3,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorApp.colorText,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 2.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: 0.75,
                        backgroundColor: colorApp.colorClip,
                        valueColor: AlwaysStoppedAnimation<Color>(colorApp.colorBlackWhite as Color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  Language.TextPost_3,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colorApp.colorTitle),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorApp.colorText,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          Language.ExamPost3_1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorApp.colorText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: colorApp.colorText,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          Language.ExamPost3_2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorApp.colorText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorApp.colorText,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          Language.ExamPost3_3,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorApp.colorText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  Language.Describe,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colorApp.colorTitle,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: TextField(
                    maxLines: 5,
                    controller: descriptionController,
                    onChanged: (data) {
                      if (descriptionController.text.isEmpty) {
                        enable = false;
                      } else {
                        enable = true;
                      }
                      setState(() {});
                    },
                    style: TextStyle(
                      fontSize: 17,
                      color: colorApp.colorText,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 46,
                    width: 195,
                    child: ElevatedButton(
                      onPressed: enable
                          ? () {
                              ref.read(projectPostingProvider.notifier).setDescription(descriptionController.text);

                              ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep4', user.role!);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          // side: const BorderSide(color: Colors.grey),
                        ),
                        backgroundColor: colorApp.colorBlackWhite,
                        disabledBackgroundColor: colorApp.colorButton,
                      ),
                      child: Text(
                        Language.Review,
                        style: TextStyle(
                          fontSize: 18,
                          color: colorApp.colorWhiteBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
