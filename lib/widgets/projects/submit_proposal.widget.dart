import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:toastification/toastification.dart';

import '../../providers/options.provider.dart';
import 'package:http/http.dart' as http;

class SubmitProposalWidget extends ConsumerStatefulWidget {
  const SubmitProposalWidget({super.key});

  @override
  ConsumerState<SubmitProposalWidget> createState() {
    return _SubmitProposalWidgetState();
  }
}

class _SubmitProposalWidgetState extends ConsumerState<SubmitProposalWidget> {
  final descriptionController = TextEditingController();
  var enable = false;
  bool isFetching = false;

  void showErrorToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
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

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final projectId = ref.watch(projectIdProvider);
    final student = ref.watch(studentProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          ref.read(optionsProvider.notifier).setWidgetOption('Dashboard', user.role!);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Cover letter',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 650,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Describe why do you fit to this project',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: TextField(
                            maxLines: 7,
                            controller: descriptionController,
                            onChanged: (data) {
                              if (descriptionController.text.isEmpty) {
                                enable = false;
                              } else {
                                enable = true;
                              }
                              setState(() {});
                            },
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 46,
                              width: 175,
                              child: ElevatedButton(
                                onPressed: () {
                                  descriptionController.text = '';
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: EdgeInsets.zero, // and this
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                  backgroundColor: Colors.white,
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
                            const SizedBox(width: 15),
                            SizedBox(
                              height: 46,
                              width: 175,
                              child: ElevatedButton(
                                onPressed: isFetching
                                    ? null
                                    : () async {
                                        setState(() {
                                          isFetching = true;
                                        });

                                        final urlPostProposals = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/proposal');

                                        final responsePostProposals = await http.post(
                                          urlPostProposals,
                                          headers: {
                                            'Content-Type': 'application/json',
                                            'Authorization': 'Bearer ${user.token}',
                                          },
                                          body: json.encode({
                                            'projectId': projectId,
                                            'studentId': student.id,
                                            'coverLetter': descriptionController.text,
                                            'statusFlag': 0,
                                            'disableFlag': 0,
                                          }),
                                        );

                                        final responsePostProposalsData = json.decode(responsePostProposals.body);
                                        print('----responsePostProposalsData----');
                                        print(responsePostProposalsData);

                                        if (responsePostProposalsData.containsKey('errorDetails')) {
                                          if (responsePostProposalsData['errorDetails'] is String) {
                                            showErrorToast('Error', responsePostProposalsData['errorDetails']);
                                          } else {
                                            showErrorToast('Error', responsePostProposalsData['errorDetails'][0]);
                                          }
                                          setState(() {
                                            isFetching = false;
                                          });
                                        } else {
                                          setState(() {
                                            isFetching = false;
                                          });

                                          ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                                          showSuccessToast('Success', 'Proposal submitted successfully');
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero, // Set this
                                  padding: EdgeInsets.zero, // and this
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                                child: isFetching
                                    ? const SizedBox(
                                        height: 17,
                                        width: 17,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'Submit proposal',
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
