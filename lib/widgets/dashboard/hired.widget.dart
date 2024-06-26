import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';
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
  final int statusFlag;

  Proposal({
    required this.proposalId,
    required this.studentName,
    required this.createTime,
    required this.techStackName,
    required this.coverLetter,
    required this.statusFlag,
  });

  Proposal.fromJson(Map<dynamic, dynamic> json)
      : proposalId = json['proposalId'],
        studentName = json['studentName'],
        createTime = json['createTime'],
        techStackName = json['techStackName'],
        coverLetter = json['coverLetter'],
        statusFlag = json['statusFlag'];

  Map<dynamic, dynamic> toJson() {
    return {
      'proposalId': proposalId,
      'studentName': studentName,
      'createTime': createTime,
      'techStackName': techStackName,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
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

  void getProjects(token, projectId, tmp) async {
    setState(() {
      isFetchingData = true;
    });

    print('----projectId----');
    print(projectId);
    final urlGetProposals = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/proposal/getByProjectId/$projectId');

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
          createTime: '${tmp.Submitted_at} ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          studentName: item['student']['user']['fullname'] ?? 'Unknown',
          techStackName: item['student']['techStack']['name'] ?? 'Unknown',
          coverLetter: item['coverLetter'] ?? 'Unknown',
          statusFlag: item['statusFlag'],
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
    final lang = ref.read(LanguageProvider);
    getProjects(user.token!, projectId, lang);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
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
            : listProposals.where((el) => el.statusFlag == 3).toList().isEmpty
                ? Column(
                    children: [
                      Text(
                        Language.empty,
                        style: TextStyle(fontSize: 16, color: colorApp.colorText),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                : Column(
                    children: [
                      ...listProposals.where((el) => el.statusFlag == 3).toList().map((el) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                border: Border.all(color: colorApp.colorBorderSide as Color),
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
                                                  style: TextStyle(
                                                    color: colorApp.colorTitle,
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
                                                  style: TextStyle(
                                                    color: colorApp.colorTime,
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
                                                  style: TextStyle(
                                                    color: colorApp.colorText,
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
                                        style: TextStyle(
                                          color: colorApp.colorText,
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
                                                side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                              ),
                                              backgroundColor: colorApp.colorWhiteBlack,
                                            ),
                                            child: Text(
                                              Language.Message,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: colorApp.colorBlackWhite,
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
                                                title: Text(
                                                  Language.HiredOffer,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                content: Text(
                                                  Language.textOffer,
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
                                                          onPressed: () => Navigator.pop(context, Language.cancel),
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              side: const BorderSide(color: Colors.black),
                                                            ),
                                                            // backgroundColor: Colors.white,
                                                          ),
                                                          child: Text(
                                                            Language.cancel,
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
                                                          onPressed: () => Navigator.pop(context, Language.Send),
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            backgroundColor: Colors.black,
                                                          ),
                                                          child: Text(
                                                            Language.Send,
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
                                              backgroundColor: colorApp.colorBlackWhite,
                                            ),
                                            child: Text(
                                              Language.textHiredoffer,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: colorApp.colorWhiteBlack,
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
