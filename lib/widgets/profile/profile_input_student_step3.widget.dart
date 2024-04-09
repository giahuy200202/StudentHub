import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/profile/student_input.provider.dart';
import 'package:studenthub/utils/resume_input.dart';
import 'package:studenthub/utils/transcript_input.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class ProfileIStudentStep3Widget extends ConsumerStatefulWidget {
  const ProfileIStudentStep3Widget({super.key});

  @override
  ConsumerState<ProfileIStudentStep3Widget> createState() {
    return _ProfileIStudentWidget();
  }
}

class _ProfileIStudentWidget extends ConsumerState<ProfileIStudentStep3Widget> {
  bool isSending = false;

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
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final studentInput = ref.watch(studentInputProvider);
    var student = ref.watch(studentProvider);
    var responseEditStudent;
    var responseEditStudentData;
    var responseCreateStudentData;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'CV & Transcript',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Tell us about your self and you will be your way connect with real-world project',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Resume/CV',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final deleteResumeUrl = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}/resume');
                      final responseDeleteResume = await http.delete(deleteResumeUrl,
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ${user.token}',
                          },
                          body: json.encode(
                            {
                              "fullname": studentInput.fullname,
                              "techStackId": studentInput.techStackId,
                              "skillSets": studentInput.skillSets,
                            },
                          ));

                      final responseDeleteResumeData = json.decode(responseDeleteResume.body);

                      print('----responseDeleteResumeData----');
                      print(responseDeleteResumeData);
                      ref.read(studentProvider.notifier).setStudentResume('');
                      ref.read(studentInputProvider.notifier).setStudentInputResume('');
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const ResumeInput(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transcript',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final deleteTranscriptUrl = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}/transcript');
                      final responseDeleteTranscript = await http.delete(deleteTranscriptUrl,
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ${user.token}',
                          },
                          body: json.encode(
                            {
                              "fullname": studentInput.fullname,
                              "techStackId": studentInput.techStackId,
                              "skillSets": studentInput.skillSets,
                            },
                          ));

                      final responseDeleteTranscriptData = json.decode(responseDeleteTranscript.body);
                      print('----responseDeleteTranscriptData----');
                      print(responseDeleteTranscriptData);
                      ref.read(studentProvider.notifier).setStudentTranscript('');
                      ref.read(studentInputProvider.notifier).setStudentInputTranscript('');
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TrasncriptInput(),
              const SizedBox(height: 60),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: !isSending
                        ? () async {
                            setState(() {
                              isSending = true;
                            });

                            if (student.id == null || student.id == 0) {
                              //Create fullname, techStackId, skillSets
                              final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student');
                              final responseCreateStudent = await http.post(url,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${user.token}',
                                  },
                                  body: json.encode(
                                    {
                                      "fullname": studentInput.fullname,
                                      "techStackId": studentInput.techStackId,
                                      "skillSets": studentInput.skillSets,
                                    },
                                  ));

                              responseCreateStudentData = json.decode(responseCreateStudent.body);
                              print('----responseCreateStudentData----');
                              print(responseCreateStudentData);

                              ref.read(studentProvider.notifier).setStudentId(responseCreateStudentData['result']['id']);

                              student = ref.watch(studentProvider);

                              if (responseCreateStudentData.containsKey('errorDetails')) {
                                if (responseCreateStudentData['errorDetails'].runtimeType == String) {
                                  showErrorToast('Error', responseCreateStudentData['errorDetails']);
                                } else {
                                  showErrorToast('Error', responseCreateStudentData['errorDetails'][0]);
                                }
                              } else {
                                showSuccessToast('Success', 'Create profile successfully');
                              }
                            } else {
                              //Edit fullname, techStackId, skillSets
                              final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}');
                              responseEditStudent = await http.put(url,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${user.token}',
                                  },
                                  body: json.encode(
                                    {
                                      "fullname": studentInput.fullname,
                                      "techStackId": studentInput.techStackId,
                                      "skillSets": studentInput.skillSets,
                                    },
                                  ));

                              responseEditStudentData = json.decode(responseEditStudent.body);
                              print('----responseEditStudentData----');
                              print(responseEditStudentData);
                            }

                            //Edit languages
                            final urlEditLanguages = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/language/updateByStudentId/${student.id}');
                            final responseEditLanguages = await http.put(urlEditLanguages,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer ${user.token}',
                                },
                                body: json.encode(
                                  {
                                    "languages": studentInput.languages,
                                  },
                                ));

                            var responseEditLanguagesData = json.decode(responseEditLanguages.body);
                            print('----responseEditLanguagesData----');
                            print(responseEditLanguagesData);

                            //Edit education
                            final urlEducation = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/education/updateByStudentId/${student.id}');
                            final responseEditEducations = await http.put(urlEducation,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer ${user.token}',
                                },
                                body: json.encode(
                                  {
                                    "education": studentInput.educations,
                                  },
                                ));

                            var responseEditEducationsData = json.decode(responseEditEducations.body);
                            print('----studentInput.education----');
                            print(json.encode(studentInput.educations));
                            print('----responseEditEducationsData----');
                            print(responseEditEducationsData);

                            //Edit experiences
                            final urlExperience = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/experience/updateByStudentId/${student.id}');
                            final responseEditExperiences = await http.put(urlExperience,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer ${user.token}',
                                },
                                body: json.encode(
                                  {
                                    "experience": studentInput.experiences,
                                  },
                                ));

                            var responseEditExperiencesData = json.decode(responseEditExperiences.body);

                            print('----studentInput.experiences----');
                            print(json.encode(studentInput.experiences));

                            print('----responseEditExperiencesData----');
                            print(responseEditExperiencesData);

                            //Set current fullname, techStackId, skillSets to provider

                            final urlGetStudent = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}');

                            final responseStudent = await http.get(
                              urlGetStudent,
                              headers: {
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${user.token}',
                              },
                            );

                            final responseStudentData = json.decode(responseStudent.body);
                            print('----responseStudentData----');
                            print(responseStudentData);

                            //set resume
                            if (studentInput.resume! != '' && studentInput.resume!.substring(0, 4) != 'http') {
                              print('-----studentInput.resume----');
                              print(studentInput.resume);
                              //update resume
                              var requestResume = http.MultipartRequest(
                                'PUT',
                                Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}/resume'),
                              );

                              // Add the token to the headers
                              requestResume.headers.addAll({
                                'Authorization': 'Bearer ${user.token}',
                              });

                              requestResume.files.add(await http.MultipartFile.fromPath(
                                'file',
                                studentInput.resume!,
                              ));
                              var responseResume = await requestResume.send();
                              http.Response finalResponseResume = await http.Response.fromStream(responseResume);

                              // set resume after update
                              final urlResume = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}/resume');
                              final responseResumeGet = await http.get(
                                urlResume,
                                headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${user.token}'},
                              );

                              var resumeData = json.decode(responseResumeGet.body)['result'];
                              ref.read(studentProvider.notifier).setStudentResume(resumeData ?? '');
                            }

                            if (studentInput.transcript! != '' && studentInput.transcript!.substring(0, 4) != 'http') {
                              //update transcript

                              print('-----studentInput.transcript----');
                              print(studentInput.transcript);
                              var requestTranscript = http.MultipartRequest(
                                'PUT',
                                Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}/transcript'),
                              );

                              // Add the token to the headers
                              requestTranscript.headers.addAll({
                                'Authorization': 'Bearer ${user.token}',
                              });

                              requestTranscript.files.add(await http.MultipartFile.fromPath(
                                'file',
                                studentInput.transcript!,
                              ));
                              var responseTranscript = await requestTranscript.send();
                              http.Response finalResponseTranscript = await http.Response.fromStream(responseTranscript);

                              //set transcript after update
                              final urlTranscript = Uri.parse('http://${dotenv.env['IP_ADDRESS']}/api/profile/student/${student.id}/transcript');
                              final responseTranscriptGet = await http.get(
                                urlTranscript,
                                headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${user.token}'},
                              );

                              var transcriptData = json.decode(responseTranscriptGet.body)['result'];
                              ref.read(studentProvider.notifier).setStudentTranscript(transcriptData ?? '');
                            }

                            if ((responseCreateStudentData != null && responseCreateStudentData.containsKey('errorDetails')) || (responseEditStudentData != null && responseEditStudentData.containsKey('errorDetails')) || responseEditLanguagesData.containsKey('errorDetails') || responseEditEducationsData.containsKey('errorDetails') || responseEditExperiencesData.containsKey('errorDetails')) {
                              showErrorToast('Error', 'Something went wrong, please check again your information');
                            } else {
                              showSuccessToast('Success', 'Edit profile successfully');
                              if (responseStudentData['result'] != null) {
                                List<int> getSkillsets = [];
                                for (var item in responseStudentData["result"]["skillSets"]) {
                                  getSkillsets.add(item['id']);
                                }

                                ref.read(studentProvider.notifier).setStudentData(
                                      student.id!,
                                      responseStudentData["result"]["fullname"],
                                      responseStudentData["result"]["email"],
                                      responseStudentData["result"]["techStack"]["id"],
                                      getSkillsets,
                                      responseStudentData["result"]["educations"],
                                      responseStudentData["result"]["experiences"],
                                      responseStudentData["result"]["languages"],
                                    );
                                Timer(const Duration(seconds: 3), () {
                                  ref.read(optionsProvider.notifier).setWidgetOption('Welcome', user.role!);
                                });
                              }
                            }

                            setState(() {
                              isSending = false;
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: isSending
                        ? const SizedBox(
                            height: 17,
                            width: 17,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
