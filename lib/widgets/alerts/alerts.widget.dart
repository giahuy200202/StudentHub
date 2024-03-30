import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertsWidget extends ConsumerStatefulWidget {
  const AlertsWidget({super.key});

  @override
  ConsumerState<AlertsWidget> createState() {
    return _AlertsWidget();
  }
}

class _AlertsWidget extends ConsumerState<AlertsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
                child: Column(children: [
              SizedBox(height: 20),
              SizedBox(
                height: 600,
                width: 400,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: 80,
                                    height: 80,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/avatar.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 90,
                                    width: 240,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '6/6/2024',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 5),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 300,
                                            child: Text(
                                              ' You have submitted to join project "Javis - AI Compllot',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(height: 20),
                                        // Container(
                                        //   alignment: Alignment.topRight,
                                        //   child: SizedBox(
                                        //     height: 40,
                                        //     width: 130,
                                        //     child: ElevatedButton(
                                        //       onPressed: () {},
                                        //       style: ElevatedButton.styleFrom(
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(8),
                                        //           side: const BorderSide(
                                        //               color: Colors.black),
                                        //         ),
                                        //         backgroundColor:
                                        //             const Color.fromARGB(
                                        //                 255, 0, 0, 0),
                                        //       ),
                                        //       child: const Text(
                                        //         'Join',
                                        //         style: TextStyle(
                                        //           fontSize: 18,
                                        //           color: Color.fromARGB(
                                        //               255, 255, 255, 255),
                                        //           fontWeight: FontWeight.w500,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: 70,
                                    height: 70,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/avatar.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 160,
                                    width: 240,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '6/6/2024',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 5),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 300,
                                            child: Text(
                                              maxLines: 3,
                                              'You have Invited to interview for project "Javis - AI Copllot at 14:00 March 20, Thrusday"',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 27),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            height: 40,
                                            width: 130,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: const BorderSide(
                                                      color: Colors.black),
                                                ),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 0, 0, 0),
                                              ),
                                              child: const Text(
                                                'Join',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              )
            ]))));
  }
}