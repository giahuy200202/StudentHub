import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/dashboard/all_projects.widget.dart';
import 'package:studenthub/widgets/dashboard/archieved.widget.dart';
import 'package:studenthub/widgets/dashboard/working.widget.dart';
import '../../providers/options_provider.dart';

class SendHireOfferScreen extends ConsumerStatefulWidget {
  const SendHireOfferScreen({super.key});

  @override
  ConsumerState<SendHireOfferScreen> createState() {
    return _SendHireOfferScreenState();
  }
}

class _SendHireOfferScreenState extends ConsumerState<SendHireOfferScreen> {
  int tabWidget = 1;

  void setTabWidget(int index) {
    setState(() {
      tabWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Your projects',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 43,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(optionsProvider.notifier)
                              .setWidgetOption('ProjectPostStep1');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero, // Set this
                          padding: EdgeInsets.zero, // and this
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 22,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Post a project',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        setTabWidget(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 1,
                        ),
                        decoration: tabWidget == 1
                            ? const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          "Proposals",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: tabWidget == 1
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        setTabWidget(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 1,
                        ),
                        decoration: tabWidget == 2
                            ? const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          "Detail",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: tabWidget == 2
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        setTabWidget(3);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 1,
                        ),
                        decoration: tabWidget == 3
                            ? const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          "Message",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: tabWidget == 3
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        setTabWidget(4);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 1,
                        ),
                        decoration: tabWidget == 4
                            ? const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          "Hired",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: tabWidget == 3
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                tabWidget == 1
                    ? AllProjects()
                    : tabWidget == 2
                        ? Working()
                        : Archieved()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
