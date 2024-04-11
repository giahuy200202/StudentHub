import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';

import '../../providers/options.provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Proposal {
  final String proposalId;
  final String studentName;
  final String createTime;
  final String techStackName;
  final String coverLetter;

  Proposal({
    required this.proposalId,
    required this.studentName,
    required this.createTime,
    required this.techStackName,
    required this.coverLetter,
  });

  Proposal.fromJson(Map<dynamic, dynamic> json)
      : proposalId = json['proposalId'],
        studentName = json['studentName'],
        createTime = json['createTime'],
        techStackName = json['techStackName'],
        coverLetter = json['coverLetter'];

  Map<dynamic, dynamic> toJson() {
    return {
      'proposalId': proposalId,
      'studentName': studentName,
      'createTime': createTime,
      'techStackName': techStackName,
      'coverLetter': coverLetter,
    };
  }
}

class HiredWidget extends ConsumerStatefulWidget {
  const HiredWidget({super.key});

  @override
  ConsumerState<HiredWidget> createState() {
    return _HiredWidgetState();
  }
}

class _HiredWidgetState extends ConsumerState<HiredWidget> {
  List<Proposal> listProposals = [];
  bool isFetchingData = false;

  void getProjects(token, projectId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetProposals = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/apiproposal/getByProjectId/$projectId');

    final responseProposals = await http.get(
      urlGetProposals,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseProposalsData = json.decode(responseProposals.body);
    print('----responseProposalsData----');
    print(responseProposalsData['result']);

    List<Proposal> listProposalsGetFromRes = [];
    if (responseProposalsData['result'] != null) {
      for (var item in responseProposalsData['result']['items']) {
        listProposalsGetFromRes.add(Proposal(
          proposalId: item['id'].toString(),
          createTime: 'Submitted at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          studentName: item['student']['user']['fullName'] ?? 'Unknown',
          techStackName: item['techStack']['name'] ?? 'Unknown',
          coverLetter: item['coverLetter'] ?? 'Unknown',
        ));
      }
    }

    print('----listProjectsGetFromRes----');
    print(listProposalsGetFromRes);

    setState(() {
      listProposals = [...listProposalsGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    final projectId = ref.read(projectIdProvider);
    getProjects(user.token!, projectId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 610,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage("assets/images/avatar.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            const Align(
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
                            const SizedBox(height: 2),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 240,
                                child: Text(
                                  '4th year student',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 94, 94, 94),
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
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 45,
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
                            // side: const BorderSide(color: Colors.grey),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage("assets/images/avatar.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            const Align(
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
                            const SizedBox(height: 2),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 240,
                                child: Text(
                                  '4th year student',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 94, 94, 94),
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
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 45,
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
                            // side: const BorderSide(color: Colors.grey),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage("assets/images/avatar.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            const Align(
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
                            const SizedBox(height: 2),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 240,
                                child: Text(
                                  '4th year student',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 94, 94, 94),
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
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 45,
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
                            // side: const BorderSide(color: Colors.grey),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
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
