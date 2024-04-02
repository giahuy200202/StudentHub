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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/avatar.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                children: [
                                  const Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 240,
                                          child: Text(
                                            'Pham Vo Cuong',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 240,
                                      child: Text(
                                        '1/4/2024',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 94, 94, 94),
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 240,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: 'Fullstack Engineer - ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Excellent',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                // fontWeight: FontWeight.w600,
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
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'I have gone through your project and it seem like a great project. I will commit for your project...',
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
                  )),
            ],
          ),
        ));
  }
}
