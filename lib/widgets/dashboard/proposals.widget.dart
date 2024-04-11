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

class ProposalsWidget extends ConsumerStatefulWidget {
  const ProposalsWidget({super.key});

  @override
  ConsumerState<ProposalsWidget> createState() {
    return _ProposalsWidgetState();
  }
}

class _ProposalsWidgetState extends ConsumerState<ProposalsWidget> {
  List<Proposal> listProposals = [];
  bool isFetchingData = false;

  void getProjects(token, projectId) async {
    setState(() {
      isFetchingData = true;
    });

    print('----projectId----');
    print(projectId);
    final urlGetProposals = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/proposal/getByProjectId/$projectId');

    final responseProposals = await http.get(
      urlGetProposals,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseProposalsData = json.decode(responseProposals.body);
    print('----responseProposalsData----');
    print(responseProposalsData);

    List<Proposal> listProposalsGetFromRes = [];

    if (responseProposalsData['result'] != null) {
      for (var item in responseProposalsData['result']['items']) {
        listProposalsGetFromRes.add(Proposal(
          proposalId: item['id'].toString(),
          createTime: 'Submitted at ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          studentName: item['student']['user']['fullname'] ?? 'Unknown',
          techStackName: item['student']['techStack']['name'] ?? 'Unknown',
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
        child: isFetchingData
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 240),
                  Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : listProposals.isEmpty
                ? const Column(
                    children: [
                      Text(
                        'Empty',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                : Column(
                    children: [
                      ...listProposals.map((el) {
                        return Column(
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
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: SizedBox(
                                                width: 240,
                                                child: Text(
                                                  el.studentName,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: SizedBox(
                                                width: 240,
                                                child: Text(
                                                  el.createTime,
                                                  style: const TextStyle(
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
                                                child: Text(
                                                  el.techStackName,
                                                  style: const TextStyle(
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
                                    const SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        el.coverLetter,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 43,
                                          width: 157,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // ref
                                              //     .read(optionsProvider.notifier)
                                              //     .setWidgetOption('ProjectPostStep1');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size.zero, // Set this
                                              padding: EdgeInsets.zero,
                                              // and this
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                side: const BorderSide(color: Colors.grey),
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: const Text(
                                              'Message',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        SizedBox(
                                          height: 43,
                                          width: 157,
                                          child: ElevatedButton(
                                            onPressed: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                                backgroundColor: Colors.white,
                                                title: const Text(
                                                  'Hired offer',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                content: const Text(
                                                  'Do you really want to send hired offer for student to do this project?',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                actionsAlignment: MainAxisAlignment.center,
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 43,
                                                        width: 135,
                                                        child: ElevatedButton(
                                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              side: const BorderSide(color: Colors.black),
                                                            ),
                                                            // backgroundColor: Colors.white,
                                                          ),
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 43,
                                                        width: 135,
                                                        child: ElevatedButton(
                                                          onPressed: () => Navigator.pop(context, 'Send'),
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            backgroundColor: Colors.black,
                                                          ),
                                                          child: const Text(
                                                            'Send',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color.fromARGB(255, 255, 255, 255),
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size.zero, // Set this
                                              padding: EdgeInsets.zero, // and this
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              backgroundColor: Colors.black,
                                            ),
                                            child: const Text(
                                              'Sent hired offer',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                fontWeight: FontWeight.w500,
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
                            const SizedBox(height: 25),
                          ],
                        );
                      }),
                    ],
                  ),
      ),
    );
  }
}
