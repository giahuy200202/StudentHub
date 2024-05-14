import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/message/receive_id.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:toastification/toastification.dart';

import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';
import '../../providers/options.provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Proposal {
  final String userId;
  final String proposalId;
  final String studentName;
  final String createTime;
  final String techStackName;
  final String coverLetter;
  final int statusFlag;

  final String educationName;

  Proposal({
    required this.userId,
    required this.proposalId,
    required this.studentName,
    required this.createTime,
    required this.techStackName,
    required this.coverLetter,
    required this.statusFlag,
    required this.educationName,
  });

  Proposal.fromJson(Map<dynamic, dynamic> json)
      : userId = json['userId'],
        proposalId = json['proposalId'],
        studentName = json['studentName'],
        createTime = json['createTime'],
        techStackName = json['techStackName'],
        coverLetter = json['coverLetter'],
        statusFlag = json['statusFlag'],
        educationName = json['educationName'];

  Map<dynamic, dynamic> toJson() {
    return {
      'userId': userId,
      'proposalId': proposalId,
      'studentName': studentName,
      'createTime': createTime,
      'techStackName': techStackName,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
      'educationName': educationName,
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

  void showSuccessToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void getProposals(token, projectId, tmp) async {
    setState(() {
      isFetchingData = true;
    });

    print('----projectId----');
    print(projectId);
    final urlGetProposals = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/proposal/getByProjectId/$projectId');
    print('-----------------urlGetProposals-----------------');
    print(urlGetProposals);

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
        listProposalsGetFromRes.add(
          Proposal(
            userId: item['student']['userId'].toString(),
            proposalId: item['id'].toString(),
            createTime: '${tmp.Createat} ${DateFormat("dd/MM/yyyy | HH:mm").format(
                  DateTime.parse(item['createdAt']).toLocal(),
                ).toString()}',
            studentName: item['student']['user']['fullname'] ?? 'Unknown',
            techStackName: item['student']['techStack']['name'] ?? 'Unknown',
            coverLetter: item['coverLetter'] ?? 'Unknown',
            statusFlag: item['statusFlag'],
            educationName: item['student']['educations'] != null && item['student']['educations'].length != 0 ? item['student']['educations'].map((e) => '${e['schoolName']} (${e['startYear']} - ${e['endYear']})').join("\n") : 'Empty',
          ),
        );
      }
    }

    print('----listProposalssGetFromRes----');
    print(json.encode(listProposalsGetFromRes));

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
    getProposals(user.token!, projectId, lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final projectId = ref.watch(projectIdProvider);

    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
    return SizedBox(
      height: 680,
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
                      ...listProposals.map((el) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  backgroundColor: colorApp.colorBackgroundBootomSheet,
                                  builder: (ctx) {
                                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: SizedBox(
                                          height: 600,
                                          child: SingleChildScrollView(
                                            // physics: const NeverScrollableScrollPhysics(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20, right: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 40),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      'Student information',
                                                      style: TextStyle(
                                                        color: colorApp.colorTitle,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: colorApp.colorDivider as Color, //                   <--- border color
                                                        width: 0.3,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          'Name: ',
                                                          style: TextStyle(
                                                            color: colorApp.colorTitle,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text(
                                                          el.studentName,
                                                          style: TextStyle(
                                                            color: colorApp.colorText,
                                                            fontSize: 17,
                                                            // fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          'Techstack: ',
                                                          style: TextStyle(
                                                            color: colorApp.colorTitle,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text(
                                                          el.techStackName,
                                                          style: TextStyle(
                                                            color: colorApp.colorText,
                                                            fontSize: 17,
                                                            // fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          'Education: ',
                                                          style: TextStyle(
                                                            color: colorApp.colorTitle,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text(
                                                          el.educationName,
                                                          style: TextStyle(
                                                            color: colorApp.colorText,
                                                            fontSize: 17,
                                                            // fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          'Cover letter: ',
                                                          style: TextStyle(
                                                            color: colorApp.colorTitle,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text(
                                                          el.coverLetter,
                                                          style: TextStyle(
                                                            color: colorApp.colorText,
                                                            fontSize: 17,
                                                            // fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorApp.colorBackgroundColor,
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
                                              onPressed: () async {
                                                final urlUpdateProposals = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/proposal/${el.proposalId}');

                                                final responseUpdateProposals = await http.patch(
                                                  urlUpdateProposals,
                                                  headers: {
                                                    'Content-Type': 'application/json',
                                                    'Authorization': 'Bearer ${user.token}',
                                                  },
                                                  body: json.encode({
                                                    "coverLetter": el.coverLetter,
                                                    "statusFlag": 1,
                                                    "disableFlag": 0,
                                                  }),
                                                );

                                                final responseUpdateProposalsData = json.decode(responseUpdateProposals.body);
                                                print('----responseUpdateProposalsData----');
                                                print(responseUpdateProposalsData);

                                                ref.read(receiveIdProvider.notifier).setReceiveId(el.userId);
                                                ref.read(optionsProvider.notifier).setWidgetOption('MessageDetails', user.role!);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size.zero, // Set this
                                                padding: EdgeInsets.zero,
                                                // and this
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                  side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                ),
                                                backgroundColor: colorApp.colorBorderBackground,
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
                                              onPressed: el.statusFlag == 0 || el.statusFlag == 1
                                                  ? () => showDialog(
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
                                                            Language.textHiredoffer,
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
                                                                SizedBox(width: 10),
                                                                SizedBox(
                                                                  height: 43,
                                                                  width: 135,
                                                                  child: ElevatedButton(
                                                                    onPressed: () async {
                                                                      print('------proposal id ------');
                                                                      print(el.proposalId);
                                                                      final urlUpdateProposals = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/proposal/${el.proposalId}');

                                                                      final responseUpdateProposals = await http.patch(
                                                                        urlUpdateProposals,
                                                                        headers: {
                                                                          'Content-Type': 'application/json',
                                                                          'Authorization': 'Bearer ${user.token}',
                                                                        },
                                                                        body: json.encode({
                                                                          "coverLetter": el.coverLetter,
                                                                          "statusFlag": 2,
                                                                          "disableFlag": 0,
                                                                        }),
                                                                      );
                                                                      print('----responseUpdateProposals----');
                                                                      print(json.decode(responseUpdateProposals.body));
                                                                      Navigator.pop(context);
                                                                      showSuccessToast('Success', 'Offer has been sent successfully');
                                                                      getProposals(user.token, projectId, Language);
                                                                    },
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
                                                      )
                                                  : null,
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size.zero, // Set this
                                                padding: EdgeInsets.zero, // and this
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                backgroundColor: colorApp.colorBlackWhite,
                                                disabledBackgroundColor: colorApp.colorButton,
                                              ),
                                              child: Text(
                                                el.statusFlag == 0
                                                    ? Language.SendOffer
                                                    : el.statusFlag == 1
                                                        ? Language.SendOffer
                                                        : el.statusFlag == 2
                                                            ? Language.offersend
                                                            : Language.Hired,
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
