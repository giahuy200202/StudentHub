import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/message/BottomSheet.widget.dart';
import 'package:studenthub/providers/options_provider.dart';

class ShowscheduleWidget extends ConsumerStatefulWidget {
  const ShowscheduleWidget({super.key});
  @override
  ConsumerState<ShowscheduleWidget> createState() {
    return _ShowscheduleWidget();
  }
}

class _ShowscheduleWidget extends ConsumerState<ShowscheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Catch up meeting',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      '60 minutes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Start time: Thursday 15:00, 13/03/2024',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'End time:   Thursday 16:00, 13/03/2024',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        const PopupMenuItem<int>(
                            value: 0,
                            child: Text(
                              'Re-schedule the interview',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Text(
                            'Cancel the meeting',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                      onSelected: (item) => {
                        if (item == 1) {print('test')} else {}
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 46,
                        width: 130,
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(optionsProvider.notifier)
                                .setWidgetOption('Videocall');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.black),
                            ),
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: const Text(
                            'Join',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
