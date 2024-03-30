import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/options.provider.dart';

class AllProjectsStudentWidget extends ConsumerStatefulWidget {
  const AllProjectsStudentWidget({
    super.key,
  });
  @override
  ConsumerState<AllProjectsStudentWidget> createState() {
    return _AllProjectsStudentWidgetState();
  }
}

class _AllProjectsStudentWidgetState
    extends ConsumerState<AllProjectsStudentWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 300,
                child: Text(
                  'Active proposal (1)',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 300,
                child: Text(
                  'Submitted proposal (1)',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
