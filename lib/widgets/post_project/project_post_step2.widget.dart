import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import '../../providers/projects/project_posting.provider.dart';
import '../../providers/options.provider.dart';

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

class ProjectPostStep2Widget extends ConsumerStatefulWidget {
  const ProjectPostStep2Widget({super.key});

  @override
  ConsumerState<ProjectPostStep2Widget> createState() {
    return _ProjectPostStep2WidgetState();
  }
}

class _ProjectPostStep2WidgetState extends ConsumerState<ProjectPostStep2Widget> {
  var numOfStudentsController = TextEditingController();
  bool enable = false;
  @override
  void dispose() {
    numOfStudentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectPosting = ref.watch(projectPostingProvider);
    final user = ref.watch(userProvider);
    return Scaffold(
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
                      ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep1', user.role!);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Estimate your project\'s scope',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Defining the project\'s scope helps ensure clarity and alignment on the objectives and deliverables from the start',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Color.fromARGB(255, 193, 191, 191),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'How long will your project take?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: 'Less than 1 month',
                        value: 0,
                        groupValue: projectPosting.scope,
                        onChanged: (value) {
                          ref.read(projectPostingProvider.notifier).setScope(value as int);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: '1 to 3 months',
                        value: 1,
                        groupValue: projectPosting.scope,
                        onChanged: (value) {
                          ref.read(projectPostingProvider.notifier).setScope(value as int);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: '3 to 6 months',
                        value: 2,
                        groupValue: projectPosting.scope,
                        onChanged: (value) {
                          ref.read(projectPostingProvider.notifier).setScope(value as int);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: 'More than 6 months',
                        value: 3,
                        groupValue: projectPosting.scope,
                        onChanged: (value) {
                          ref.read(projectPostingProvider.notifier).setScope(value as int);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'How many students do you want for this project?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: TextField(
                    controller: numOfStudentsController,
                    onChanged: (data) {
                      if (numOfStudentsController.text.isEmpty) {
                        enable = false;
                      } else {
                        enable = true;
                      }
                      setState(() {});
                    },
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      // labelText: 'Number of students',
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
                      hintText: 'Number of students',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 46,
                    width: 195,
                    child: ElevatedButton(
                      onPressed: enable
                          ? () {
                              ref.read(projectPostingProvider.notifier).setNumOfStudents(numOfStudentsController.text);

                              ref.read(optionsProvider.notifier).setWidgetOption('ProjectPostStep3', user.role!);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          // side: const BorderSide(color: Colors.grey),
                        ),
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text(
                        'Next: Description',
                        style: TextStyle(
                          fontSize: 16,
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
