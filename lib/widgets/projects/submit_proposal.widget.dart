import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';

import '../../providers/options.provider.dart';

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

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        ref
                            .read(optionsProvider.notifier)
                            .setWidgetOption('ProjectDetails', user.role!);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Cover letter',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
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
                                borderSide:
                                    const BorderSide(color: Colors.black),
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
                                  // ref
                                  //     .read(optionsProvider.notifier)
                                  //     .setWidgetOption('SubmitProposal');
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
                                    fontSize: 18,
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
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                                child: const Text(
                                  'Submit proposal',
                                  style: TextStyle(
                                    fontSize: 18,
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
