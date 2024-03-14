import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';
import 'package:studenthub/providers/Profile_provider.dart';

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

class ProfileInputWidget extends ConsumerStatefulWidget {
  const ProfileInputWidget({super.key});

  @override
  ConsumerState<ProfileInputWidget> createState() {
    return _ProfileInputWidgetState();
  }
}

class _ProfileInputWidgetState extends ConsumerState<ProfileInputWidget> {
  var enable = false;
  final textCompany = TextEditingController();
  final textWebsite = TextEditingController();
  final textDescription = TextEditingController();

  @override
  void dispose() {
    textCompany.dispose();
    textWebsite.dispose();
    textDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedEmployee = ref.watch(selectedEmployeeProvider);
    ref.watch(TextCompanyEmployeeProvider);
    ref.watch(TextWebsiteEmpoyleeProvider);
    ref.watch(TextDescriptionEmpoyleeProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Welcome to Student Hub',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tell us about your company and you will be on your way connect with high-skilled students',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'How many people in company?',
                style: TextStyle(fontSize: 16),
              ),

              ////////////////////////////////////////
              const SizedBox(height: 15),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: 'It\'s just me',
                      value: 1,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: '2-9 employees',
                      value: 2,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: '10-99 employees',
                      value: 3,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: "100-1000 employees",
                      value: 4,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    child: LabeledRadio(
                      label: 'More than 1000 employees',
                      value: 5,
                      groupValue: selectedEmployee,
                      onChanged: (value) {
                        ref
                            .read(selectedEmployeeProvider.notifier)
                            .selectEmployee(value!);
                      },
                    ),
                  ),
                ],
              ),

              //////////////////////////////////////
              const SizedBox(height: 15),
              const Text(
                'Company name',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: textCompany,
                  onChanged: (data) {
                    if (textCompany.text.isEmpty || textCompany.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                      ref
                          .read(TextCompanyEmployeeProvider.notifier)
                          .TextCompanye(data);
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
                      vertical: 0,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              //////
              const Text(
                'Website',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: textWebsite,
                  onChanged: (data) {
                    if (textWebsite.text.isEmpty || textWebsite.text.isEmpty) {
                      enable = false;
                    } else {
                      enable = true;
                      ref
                          .read(TextWebsiteEmpoyleeProvider.notifier)
                          .TextWebsitee(data);
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
                      vertical: 0,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              //////
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Description',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: TextField(
                  maxLines: 4,
                  controller: textDescription,
                  onChanged: (data) {
                    if (textDescription.text.isEmpty ||
                        textDescription.text.isEmpty) {
                      enable = false;
                    } else {
                      ref
                          .read(TextDescriptionEmpoyleeProvider.notifier)
                          .TextDescriptione(data);
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

              ///
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 46,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: enable
                        ? () {
                            ref
                                .read(optionsProvider.notifier)
                                .setWidgetOption('Welcome');
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        // side: const BorderSide(color: Colors.black),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text(
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

              ///
            ],
          ),
        ),
      ),
    );
  }
}
