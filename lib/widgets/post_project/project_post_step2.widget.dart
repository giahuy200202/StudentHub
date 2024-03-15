import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/postprofile_provider.dart';
import '../../providers/options_provider.dart';

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

class _ProjectPostStep2WidgetState
    extends ConsumerState<ProjectPostStep2Widget> {
  var titleController = TextEditingController();
  bool enable = false;
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedMonth = ref.watch(selectmonthProvider);

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
                      '2/4',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Next, estimate the scope of your job',
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
                  'Consider the size of your project and the timeline',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'How long will your project take?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: '1 to 3 months',
                        value: 1,
                        groupValue: selectedMonth,
                        onChanged: (value) {
                          ref
                              .read(selectmonthProvider.notifier)
                              .selectMonth(value!);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: LabeledRadio(
                        label: '3 to 6 months',
                        value: 2,
                        groupValue: selectedMonth,
                        onChanged: (value) {
                          ref
                              .read(selectmonthProvider.notifier)
                              .selectMonth(value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 270),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 46,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: enable
                          ? () {
                              ref
                                  .read(optionsProvider.notifier)
                                  .setWidgetOption('ProjectPostStep2');
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
                        'Next: Scope',
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