import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options.provider.dart';
import '../../providers/projects/project_posting.provider.dart';
// import '../../providers/options_provider.dart';

class DetailWidget extends ConsumerStatefulWidget {
  const DetailWidget({super.key});

  @override
  ConsumerState<DetailWidget> createState() {
    return _DetailWidgetState();
  }
}

class _DetailWidgetState extends ConsumerState<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    final projectPosting = ref.watch(projectPostingProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                      'Title of the job',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                const Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 340,
                    child: Text(
                      'Created 1 minute ago',
                      style: TextStyle(
                        color: Color.fromARGB(255, 94, 94, 94),
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
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
                const SizedBox(height: 20),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Project scope',
                              style: TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '3 to 6 month',
                              style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Student required',
                              style: TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '6 students',
                              style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 105),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              // ref
              //     .read(optionsProvider.notifier)
              //     .setWidgetOption('ProjectPostStep1');
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
              'Post job',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
