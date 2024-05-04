import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/switch_account.provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SwitchAccountWidget extends ConsumerStatefulWidget {
  const SwitchAccountWidget({super.key});

  @override
  ConsumerState<SwitchAccountWidget> createState() {
    return _SwitchAccountWidgetState();
  }
}

class _SwitchAccountWidgetState extends ConsumerState<SwitchAccountWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // final tasks = ref.watch(tasksProvider);
    final user = ref.watch(userProvider);
    final student = ref.watch(studentProvider);
    final company = ref.watch(companyProvider);

    Icon icon = isChecked
        ? const Icon(Icons.keyboard_arrow_up_outlined, size: 40, color: Color.fromARGB(255, 121, 123, 125))
        : const Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 40,
            color: Color.fromARGB(255, 151, 153, 155),
          );

    Widget firstRow = user.role == '1'
        ? TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: InkWell(
              onTap: () {
                ref.read(userProvider.notifier).setRole("1");
                ref.read(switchAccountProvider.notifier).setSwitchAccount(
                      "1",
                    );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SizedBox(
                  // width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 40,
                          color: Color.fromARGB(255, 121, 123, 125),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment.start, //Center Column contents horizontally,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    company.id == null || company.id == 0 ? 'Anonymous' : company.companyName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Company',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 73, 80, 87),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: icon,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: InkWell(
              onTap: () {
                ref.read(userProvider.notifier).setRole("0");
                ref.read(switchAccountProvider.notifier).setSwitchAccount(
                      "0",
                    );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SizedBox(
                  // width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 40,
                          color: Color.fromARGB(255, 121, 123, 125),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment.start, //Center Column contents horizontally,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    student.id == null || student.id == 0 ? 'Anonymous' : student.fullname!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Student',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 73, 80, 87),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: icon,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

    Widget secondRow = user.role == '1'
        ? TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: InkWell(
              onTap: () {
                ref.read(userProvider.notifier).setRole("0");
                ref.read(switchAccountProvider.notifier).setSwitchAccount(
                      "0",
                    );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SizedBox(
                  // width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Color.fromARGB(255, 121, 123, 125),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.person,
                          size: 40,
                          color: Color.fromARGB(255, 121, 123, 125),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment.start, //Center Column contents horizontally,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    student.id == null || student.id == 0 ? 'Anonymous' : student.fullname!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Student',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 73, 80, 87),
                                      fontSize: 16,
                                    ),
                                  ),
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
            ),
          )
        : TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: InkWell(
              onTap: () {
                ref.read(userProvider.notifier).setRole("1");
                ref.read(switchAccountProvider.notifier).setSwitchAccount(
                      "1",
                    );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SizedBox(
                  // width: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Color.fromARGB(255, 121, 123, 125),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.person,
                          size: 40,
                          color: Color.fromARGB(255, 121, 123, 125),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment.start, //Center Column contents horizontally,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    company.id == null || company.id == 0 ? 'Anonymous' : company.companyName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 240,
                                  child: Text(
                                    'Company',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 73, 80, 87),
                                      fontSize: 16,
                                    ),
                                  ),
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
            ),
          );

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 35),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Table(
                  border: const TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid)),
                  columnWidths: const <int, TableColumnWidth>{
                    // 0: IntrinsicColumnWidth(),
                    // 1: FlexColumnWidth(),
                    // 2: FixedColumnWidth(64),
                  },
                  children: [
                    TableRow(
                      children: [firstRow],
                    ),
                    isChecked
                        ? TableRow(
                            children: [secondRow],
                          )
                        : const TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: SizedBox(
                                  // width: 250,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: [],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: InkWell(
                            onTap: () {
                              ref.read(optionsProvider.notifier).setWidgetOption(user.role == '1' ? (company.id == null || company.id == 0 || company.id == 0 ? 'ProfileInput' : 'ViewProfile') : 'ProfileInputStudent', user.role!);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: SizedBox(
                                // width: 250,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_2_outlined,
                                        size: 40,
                                        color: Color.fromARGB(255, 121, 123, 125),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 240,
                                            child: Text(
                                              'Profiles',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 73, 80, 87),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: SizedBox(
                              // width: 250,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.settings_outlined,
                                      size: 40,
                                      color: Color.fromARGB(255, 121, 123, 125),
                                    ),
                                    SizedBox(width: 10),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 240,
                                          child: Text(
                                            'Setting',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 73, 80, 87),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: InkWell(
                            onTap: () {
                              ref.read(optionsProvider.notifier).setWidgetOption('ChangePassword', user.role!);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: SizedBox(
                                // width: 250,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.key,
                                        size: 40,
                                        color: Color.fromARGB(255, 121, 123, 125),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 240,
                                            child: Text(
                                              'Change password',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 73, 80, 87),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: InkWell(
                            onTap: () async {
                              final urlLogout = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/auth/logout');

                              final responseLogout = await http.post(
                                urlLogout,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer ${user.token}',
                                },
                                body: json.encode({}),
                              );

                              final responseLogoutData = json.decode(responseLogout.body);
                              print('----responseLogoutData----');
                              print(responseLogoutData);

                              ref.read(userProvider.notifier).setUserData(0, '', '');
                              ref.read(companyProvider.notifier).setCompanyData(0, '', '', '', '', 0);
                              ref.read(studentProvider.notifier).setStudentData(0, '', '', 0, [], [], [], []);
                              ref.read(optionsProvider.notifier).setWidgetOption('', user.role!);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: SizedBox(
                                // width: 250,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        size: 40,
                                        color: Color.fromARGB(255, 121, 123, 125),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 240,
                                            child: Text(
                                              'Logout',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 73, 80, 87),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
