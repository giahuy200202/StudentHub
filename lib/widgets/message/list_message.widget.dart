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
        height: 600,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(optionsProvider.notifier).setWidgetOption('MessageDetails', user.role!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 232, 233, 237),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.4,
                    ),
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
                            Container(
                              width: 65,
                              height: 65,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/avatar.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    'Luis Pham',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 240,
                                  child: Text(
                                    '12/04/2020 | 14:07',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 115, 114, 114),
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Senior frontend developer (Fintech)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
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
                              color: Colors.black, //                   <--- border color
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
            ],
          ),
        ));
  }
}
