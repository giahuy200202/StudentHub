import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/project_posting_provider.dart';
import '../../providers/options_provider.dart';

class ProjectPostStep3Widget extends ConsumerStatefulWidget {
  const ProjectPostStep3Widget({super.key});

  @override
  ConsumerState<ProjectPostStep3Widget> createState() {
    return _ProjectPostStep3WidgetState();
  }
}

class _ProjectPostStep3WidgetState
    extends ConsumerState<ProjectPostStep3Widget> {
  var descriptionController = TextEditingController();
  bool enable = false;
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      '3/4',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Next, provide project description',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Students are looking for',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '1.  Clear expectation about your project or deliverables',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '2.  The skills required for your project',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '3.  Detail about your project',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Describe your project',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(color: Colors.black),
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
                              ref
                                  .read(projectPostingProvider.notifier)
                                  .setDescription(descriptionController.text);

                              ref
                                  .read(optionsProvider.notifier)
                                  .setWidgetOption('ProjectPostStep4');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          // side: const BorderSide(color: Colors.black),
                        ),
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text(
                        'Review your post',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
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
