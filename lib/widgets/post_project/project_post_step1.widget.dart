import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/projects/project_posting.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

import '../../providers/options.provider.dart';

class ProjectPostStep1Widget extends ConsumerStatefulWidget {
  const ProjectPostStep1Widget({super.key});

  @override
  ConsumerState<ProjectPostStep1Widget> createState() {
    return _ProjectPostStep1WidgetState();
  }
}

class _ProjectPostStep1WidgetState extends ConsumerState<ProjectPostStep1Widget> {
  var titleController = TextEditingController();
  bool enable = false;
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    var colorApp = ref.watch(colorProvider);

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
                      ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
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
                    'Let\'s start with a strong title',
                    style: TextStyle(
                      fontSize: 27,
                      color: colorApp.colorTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'This helps your post stand out to the right students. It\'s the first thing they\'ll see, so make it impressive!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorApp.colorText,
                    // fontWeight: FontWeight.w700,
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
                        value: 0.25,
                        backgroundColor: colorApp.colorClip,
                        valueColor: AlwaysStoppedAnimation<Color>(colorApp.colorBlackWhite as Color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Title',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colorApp.colorTitle),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: TextField(
                    controller: titleController,
                    onChanged: (data) {
                      if (titleController.text.isEmpty) {
                        enable = false;
                      } else {
                        enable = true;
                      }
                      setState(() {});
                    },
                    style: TextStyle(
                      fontSize: 16,
                      color: colorApp.colorText,
                    ),
                    decoration: InputDecoration(
                        // labelText: 'Write a title for your post',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        hintText: 'Write a title for your post',
                        hintStyle: TextStyle(
                          color: colorApp.colorText,
                        )),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Example titles',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colorApp.colorTitle,
                  ),
                ),
                const SizedBox(height: 20),
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
                          'Build responsive WordPress site with booking/payment functionality',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: colorApp.colorText),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
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
                          'Facebook ad specialist need for product launch',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: colorApp.colorText,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 46,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: enable
                          ? () {
                              ref.read(projectPostingProvider.notifier).setTitle(titleController.text);

                              ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep2', user.role!);
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
                        'Next: Scope',
                        style: TextStyle(
                          fontSize: 16,
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
