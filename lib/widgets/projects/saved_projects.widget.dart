import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication_provider.dart';

import '../../providers/options_provider.dart';

class SavedProjectsWidget extends ConsumerStatefulWidget {
  const SavedProjectsWidget({super.key});

  @override
  ConsumerState<SavedProjectsWidget> createState() {
    return _SavedProjectsWidgetState();
  }
}

class _SavedProjectsWidgetState extends ConsumerState<SavedProjectsWidget> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      ref
                          .read(optionsProvider.notifier)
                          .setWidgetOption('Projects', user.role!);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Saved projects',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 650,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 233, 235, 240),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 28,
                                    ),
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
                                    color: Colors
                                        .black, //                   <--- border color
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
                                    color: Colors
                                        .black, //                   <--- border color
                                    width: 0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Row(
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
                                    'Proposals: Less than 5',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 233, 235, 240),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 28,
                                    ),
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
                                    color: Colors
                                        .black, //                   <--- border color
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
                                    color: Colors
                                        .black, //                   <--- border color
                                    width: 0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Row(
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
                                    'Proposals: Less than 5',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
