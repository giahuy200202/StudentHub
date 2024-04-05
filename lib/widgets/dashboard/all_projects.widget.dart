import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';

import '../../providers/options.provider.dart';

class Projectdetails {
  String? title;
  String? description;
  int? numberStudent;
  int? projectScope;

  Projectdetails({
    this.title,
    this.description,
    this.numberStudent,
    this.projectScope,
  });
}

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

class AllProjectsWidget extends ConsumerStatefulWidget {
  const AllProjectsWidget({super.key});

  @override
  ConsumerState<AllProjectsWidget> createState() {
    return _AllProjectsWidgetState();
  }
}

class _AllProjectsWidgetState extends ConsumerState<AllProjectsWidget> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var numOfStudentsController = TextEditingController();

  void openMoreOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: 330,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 52,
                          width: 168,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.format_indent_increase_rounded,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'View proposals',
                                    style: TextStyle(
                                      fontSize: 16,
                                      // color: Color.fromARGB(255, 255, 255, 255),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 52,
                          width: 168,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'View messages',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 52,
                          width: 168,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_3,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'View hired',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 52,
                          width: 168,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.list_alt_outlined,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'View job posting',
                                    style: TextStyle(
                                      fontSize: 16,
                                      // color: Color.fromARGB(255, 255, 255, 255),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 52,
                          width: 168,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (ctx) {
                                  return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                    titleController.text = 'Senior frontend developer (Fintech)';
                                    descriptionController.text = 'This practice lesson consists of short paragraphs about interesting subjects. Find fun keyboard typing practice—and learn something new! Our paragraph practice is great typing practice for writing essays, reports, emails, and more for school and work.';
                                    numOfStudentsController.text = '1';
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: SingleChildScrollView(
                                        // physics: const NeverScrollableScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(height: 40),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Edit project",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black, //                   <--- border color
                                                    width: 0.3,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              SizedBox(
                                                height: 580,
                                                child: Column(
                                                  children: [
                                                    const Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        "Title",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    SizedBox(
                                                      child: TextField(
                                                        controller: titleController,
                                                        onChanged: (data) {},
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
                                                            borderSide: const BorderSide(color: Colors.black),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 15,
                                                          ),
                                                          hintText: 'Enter your languages',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        'Project scope',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 30,
                                                          width: MediaQuery.of(context).size.width,
                                                          child: LabeledRadio(
                                                            label: '1 to 3 months',
                                                            value: 1,
                                                            groupValue: 0, //projectPosting.scope,
                                                            onChanged: (value) {
                                                              // ref.read(projectPostingProvider.notifier).setScope(value as int);
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                          width: MediaQuery.of(context).size.width,
                                                          child: LabeledRadio(
                                                            label: '3 to 6 months',
                                                            value: 2,
                                                            groupValue: 2,
                                                            onChanged: (value) {
                                                              // ref.read(projectPostingProvider.notifier).setScope(value as int);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        "Number of students",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    SizedBox(
                                                      child: TextField(
                                                        controller: numOfStudentsController,
                                                        onChanged: (data) {},
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
                                                            borderSide: const BorderSide(color: Colors.black),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 15,
                                                          ),
                                                          hintText: 'Enter your language level',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        "Description",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    SizedBox(
                                                      child: TextField(
                                                        maxLines: 3,
                                                        controller: descriptionController,
                                                        onChanged: (data) {},
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
                                                            borderSide: const BorderSide(color: Colors.black),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 15,
                                                          ),
                                                          hintText: 'Enter your language level',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 35),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              height: 46,
                                                              width: 175,
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  minimumSize: Size.zero, // Set this
                                                                  padding: EdgeInsets.zero, // and this
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    side: const BorderSide(color: Colors.black),
                                                                  ),
                                                                  backgroundColor: Colors.white,
                                                                ),
                                                                child: const Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width: 15),
                                                            SizedBox(
                                                              height: 46,
                                                              width: 175,
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  minimumSize: Size.zero, // Set this
                                                                  padding: EdgeInsets.zero, // and this
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  backgroundColor: Colors.black,
                                                                ),
                                                                child: const Text(
                                                                  'Edit',
                                                                  style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit_calendar_outlined,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Edit posting',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 52,
                          width: 168,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_forever,
                                    size: 22,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Remove posting',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.zero, // and this
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Start working this project',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SizedBox(
      height: 545,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.read(optionsProvider.notifier).setWidgetOption('SendHireOffer', user.role!);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 300,
                              child: Text(
                                'Senior frontend developer (Fintech)',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: openMoreOverlay,
                            child: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 340,
                          child: Text(
                            'Created 3 days ago',
                            style: TextStyle(
                              color: Color.fromARGB(255, 94, 94, 94),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 340,
                          child: Text(
                            'Time: 1-3 months, 6 students needed',
                            style: TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //                   <--- border color
                            width: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'This practice lesson consists of short paragraphs about interesting subjects. Find fun keyboard typing practice—and learn something new! Our paragraph practice is great typing practice for writing essays, reports, emails, and more for school and work.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //                   <--- border color
                            width: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Proposals',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '8',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Messages',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Hired',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                ref.read(optionsProvider.notifier).setWidgetOption('SendHireOffer', user.role!);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 300,
                              child: Text(
                                'Senior frontend developer (Fintech)',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: openMoreOverlay,
                            child: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 340,
                          child: Text(
                            'Created 3 days ago',
                            style: TextStyle(
                              color: Color.fromARGB(255, 94, 94, 94),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 340,
                          child: Text(
                            'Time: 1-3 months, 6 students needed',
                            style: TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //                   <--- border color
                            width: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'This practice lesson consists of short paragraphs about interesting subjects. Find fun keyboard typing practice—and learn something new! Our paragraph practice is great typing practice for writing essays, reports, emails, and more for school and work.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //                   <--- border color
                            width: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Proposals',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '8',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Messages',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Hired',
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
