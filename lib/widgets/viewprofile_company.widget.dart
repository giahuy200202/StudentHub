import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';

// class LabeledRadio<T> extends StatelessWidget {
//   const LabeledRadio({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.groupValue,
//     required this.onChanged,
//   }) : super(key: key);

//   final String label;
//   final T value;
//   final T? groupValue;
//   final ValueChanged<T?> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onChanged(value);
//       },
//       child: Row(
//         children: <Widget>[
//           Radio<T>(
//             value: value,
//             groupValue: groupValue,
//             onChanged: onChanged,
//           ),
//           Text(label),
//         ],
//       ),
//     );
//   }
// }

class ViewProfileCompanyWidget extends ConsumerWidget {
  const ViewProfileCompanyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    var selectedEmployee = ref.watch(selectedEmployeeProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Welcome to Student Hub',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /////////////
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Company name',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 90,
                  child: TextField(
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 13.5,
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
                ////////////////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
