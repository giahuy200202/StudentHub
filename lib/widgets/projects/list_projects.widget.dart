import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication_provider.dart';

import '../../providers/options_provider.dart';

class ListProjectsWidget extends ConsumerStatefulWidget {
  const ListProjectsWidget({super.key});

  @override
  ConsumerState<ListProjectsWidget> createState() {
    return _ListProjectsWidgetState();
  }
}

class _ListProjectsWidgetState extends ConsumerState<ListProjectsWidget> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return SizedBox(
      height: 590,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref
                    .read(optionsProvider.notifier)
                    .setWidgetOption('ProjectDetails', user.role!);
              },
              child: Container(
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
                              Icons.favorite_border,
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
                            Icons.favorite_border,
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
    );
  }
}
