import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';

import '../../providers/options.provider.dart';

class Message extends ConsumerStatefulWidget {
  const Message({super.key});

  @override
  ConsumerState<Message> createState() {
    return _MessageState();
  }
}

class _MessageState extends ConsumerState<Message> {
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
                      .setWidgetOption('MessageDetails', user.role!);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 232, 233, 237),
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
                            Container(
                              width: 70,
                              height: 70,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/avatar.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 240,
                                    child: Text(
                                      'Luis Pham',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 260,
                                    child: Text(
                                      'Senior frontend developer (Fintech)',
                                      style: TextStyle(
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                            'Clear expectation about your project or dellverables',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // ref
                  //     .read(optionsProvider.notifier)
                  //     .setWidgetOption('ProjectDetails');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 232, 233, 237),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 250,
                                child: Text(
                                  'Luis Pham',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text('6/6/2024')
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 340,
                            child: Text(
                              'Senior frontend developer (Fintech)',
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
                            'Clear expectation about your project or dellverables',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // ref
                  //     .read(optionsProvider.notifier)
                  //     .setWidgetOption('ProjectDetails');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 232, 233, 237),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 250,
                                child: Text(
                                  'Luis Pham',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text('6/6/2024')
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 340,
                            child: Text(
                              'Senior frontend developer (Fintech)',
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
                            'Clear expectation about your project or dellverables',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // ref
                  //     .read(optionsProvider.notifier)
                  //     .setWidgetOption('ProjectDetails');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 232, 233, 237),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 250,
                                child: Text(
                                  'Luis Pham',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text('6/6/2024')
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 340,
                            child: Text(
                              'Senior frontend developer (Fintech)',
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
                            'Clear expectation about your project or dellverables',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
