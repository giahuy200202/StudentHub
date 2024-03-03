import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';

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
          Text(label),
        ],
      ),
    );
  }
}

class ProfileCompanyWidget extends ConsumerWidget {
  const ProfileCompanyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedEmployee = ref.watch(selectedEmployeeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Student Hub',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tell us about your company and you will be on your way connect with high-skilled students',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'How many people in company?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                ////////////////////////////////////////
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledRadio(
                        label: 'It\'s just me',
                        value: 1,
                        groupValue: selectedEmployee,
                        onChanged: (value) {
                          ref
                              .read(selectedEmployeeProvider.notifier)
                              .selectEmployee(value!);
                        },
                      ),
                      LabeledRadio(
                        label: '2-9 employees',
                        value: 2,
                        groupValue: selectedEmployee,
                        onChanged: (value) {
                          ref
                              .read(selectedEmployeeProvider.notifier)
                              .selectEmployee(value!);
                        },
                      ),
                      LabeledRadio(
                        label: '10-99 employees',
                        value: 3,
                        groupValue: selectedEmployee,
                        onChanged: (value) {
                          ref
                              .read(selectedEmployeeProvider.notifier)
                              .selectEmployee(value!);
                        },
                      ),
                      LabeledRadio(
                        label: '100-1000 employees',
                        value: 4,
                        groupValue: selectedEmployee,
                        onChanged: (value) {
                          ref
                              .read(selectedEmployeeProvider.notifier)
                              .selectEmployee(value!);
                        },
                      ),
                      LabeledRadio(
                        label: 'More than 1000 employees',
                        value: 5,
                        groupValue: selectedEmployee,
                        onChanged: (value) {
                          ref
                              .read(selectedEmployeeProvider.notifier)
                              .selectEmployee(value!);
                        },
                      ),
                    ],
                  ),
                ),
                //////////////////////////////////////
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Company',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: TextField(
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
                        vertical: 17,
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
                ///////
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Website',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: TextField(
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
                        vertical: 17,
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
                //////
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Description',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 85,
                  child: TextField(
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
                        vertical: 17,
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),

                ///

                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 30,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
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
      ),
    );
  }
}
