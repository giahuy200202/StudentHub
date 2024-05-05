import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/notifications/local_notification.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/message/receive_id.provider.dart';
import 'package:studenthub/providers/notification/messages.provider.dart';
import 'package:studenthub/providers/notification/notifications.provider.dart';
import 'package:studenthub/providers/profile/company.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/widgets/message/message_details.widget.dart';
import 'package:studenthub/widgets/message/body_message.widget.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/widgets/message/BottomSheet.widget.dart';
import 'package:studenthub/widgets/message/schedule.widget.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class Message {
  final String createdAt;
  final String author;
  final String content;
  final bool isInterview;
  final String titleInterview;
  final String startTimeInterview;
  final String endTimeInterview;

  Message({
    required this.createdAt,
    required this.author,
    required this.content,
    required this.isInterview,
    required this.titleInterview,
    required this.startTimeInterview,
    required this.endTimeInterview,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : createdAt = json['createdAt'],
        author = json['author'],
        content = json['content'],
        isInterview = json['isInterview'],
        titleInterview = json['titleInterview'],
        startTimeInterview = json['startTimeInterview'],
        endTimeInterview = json['endTimeInterview'];

  Map<dynamic, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'author': author,
      'content': content,
      'isInterview': isInterview,
      'titleInterview': titleInterview,
      'startTimeInterview': startTimeInterview,
      'endTimeInterview': endTimeInterview,
    };
  }
}

class MessageDetailsScreen extends ConsumerStatefulWidget {
  const MessageDetailsScreen({super.key});

  @override
  ConsumerState<MessageDetailsScreen> createState() {
    return _MessageDetailsScreen();
  }
}

class _MessageDetailsScreen extends ConsumerState<MessageDetailsScreen> {
  bool isFetchingData = false;

  var sendMessage = TextEditingController();
  bool enable = false;

  var videoInterviewTitleController = TextEditingController();

  var dateControllerStart = TextEditingController(text: 'Select Date');
  var timeControllerStart = TextEditingController(text: 'Select Time');

  DateTime? selectedDateStart;
  TimeOfDay? selectedTimeStart;

  var dateControllerEnd = TextEditingController(text: 'Select Date');
  var timeControllerEnd = TextEditingController(text: 'Select Time');

  DateTime? selectedDateEnd;
  TimeOfDay? selectedTimeEnd;

  bool isCancel = false;

  void setIsCancel(bool value) {
    setState(() {
      isCancel = value;
    });
  }

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

  void getMessages(token, projectId, receiveId) async {
    setState(() {
      isFetchingData = true;
    });

    final urlGetMessages = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/message/$projectId/user/$receiveId');

    final responseMessages = await http.get(
      urlGetMessages,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseMessagesData = json.decode(responseMessages.body);
    print('----responseMessagesData----');
    print(responseMessagesData['result']);

    List<Message> listMessagesGetFromRes = [];
    if (responseMessagesData['result'] != null) {
      ref.read(messageProvider.notifier).clearMessageData();
      for (var item in responseMessagesData['result']) {
        if (item['interview'] == null) {
          ref.read(messageProvider.notifier).pushMessageData(
                DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(item['createdAt']).toLocal()).toString(),
                item['sender']['fullname'],
                item['content'],
                false,
                '',
                '',
                '',
              );
        } else {
          ref.read(messageProvider.notifier).pushMessageData(
                DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(item['createdAt']).toLocal()).toString(),
                item['sender']['fullname'],
                'New interview was created',
                true,
                item['interview']['title'],
                item['interview']['startTime'],
                item['interview']['endTime'],
              );
        }
      }
    }

    setState(() {
      isFetchingData = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sendMessage.dispose();
    super.dispose();
  }

  void presentDatePickerStart() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      selectedDateStart = pickedDate;
    });
    dateControllerStart.text = DateFormat('dd/MM/yyyy').format(selectedDateStart!).toString();
  }

  void presentTimePickerStart() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    setState(() {
      selectedTimeStart = pickedTime;
    });

    timeControllerStart.text = '${pickedTime!.hour}:${pickedTime.minute}';
  }

  void presentDatePickerEnd() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      selectedDateEnd = pickedDate;
    });
    dateControllerEnd.text = DateFormat('dd/MM/yyyy').format(selectedDateEnd!).toString();
  }

  void presentTimePickerEnd() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    setState(() {
      selectedTimeEnd = pickedTime;
    });

    timeControllerEnd.text = '${pickedTime!.hour <= 9 && pickedTime.hour >= 0 ? pickedTime.hour : pickedTime.hour}:${pickedTime.minute}';
  }

  @override
  void initState() {
    super.initState();

    final user = ref.read(userProvider);
    final projectId = ref.read(projectIdProvider);
    final receiveId = ref.read(receiveIdProvider);

    getMessages(user.token!, projectId, receiveId);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final projectId = ref.watch(projectIdProvider);
    final company = ref.watch(companyProvider);
    final receiveId = ref.watch(receiveIdProvider);

    final listMessages = ref.watch(messageProvider);

    return isFetchingData
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 200),
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
        : SizedBox(
            height: 1000,
            child: SingleChildScrollView(
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
                                ref.read(optionsProvider.notifier).setWidgetOption('Message', user.role!);
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
                              'Message details',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 670,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...listMessages.map(
                                (el) {
                                  return Column(
                                    children: [
                                      !el.isInterview
                                          ? Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    padding: const EdgeInsets.all(0),
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      image: DecorationImage(
                                                        image: AssetImage("assets/images/avatar.jpg"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 300,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 160,
                                                                child: Text(
                                                                  el.author,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                el.createdAt,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                  color: Color.fromARGB(255, 119, 118, 118),
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: SizedBox(
                                                        width: 300,
                                                        child: Text(
                                                          el.content,
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            // overflow: TextOverflow.ellipsis,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    padding: const EdgeInsets.all(0),
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      image: DecorationImage(
                                                        image: AssetImage("assets/images/avatar.jpg"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 300,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 160,
                                                                child: Text(
                                                                  el.author,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                el.createdAt,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                  color: Color.fromARGB(255, 119, 118, 118),
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 15),
                                                    SizedBox(
                                                      height: 210,
                                                      width: 310,
                                                      child: Container(
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
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    el.titleInterview,
                                                                    style: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  Text(
                                                                    '${DateTime.parse(el.endTimeInterview).difference(DateTime.parse(el.startTimeInterview)).inMinutes} minutes',
                                                                    style: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 20),
                                                              Text(
                                                                'Start time:   ${DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(el.startTimeInterview)).toString()}',
                                                                style: const TextStyle(fontSize: 16),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              Text(
                                                                'End time:   ${DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(el.endTimeInterview)).toString()}',
                                                                style: const TextStyle(fontSize: 16),
                                                              ),
                                                              const SizedBox(height: 20),
                                                              isCancel == false
                                                                  ? Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        PopupMenuButton<int>(
                                                                          itemBuilder: (context) => [
                                                                            const PopupMenuItem<int>(
                                                                                value: 0,
                                                                                child: Text(
                                                                                  'Re-schedule the interview',
                                                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                                                                )),
                                                                            const PopupMenuItem<int>(
                                                                              value: 1,
                                                                              child: Text(
                                                                                'Cancel the meeting',
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                          onSelected: (item) => {
                                                                            // if (item == 1)
                                                                            //   {
                                                                            //     setIsCancel(true),
                                                                            //   }
                                                                            // else
                                                                            //   {
                                                                            //     openMoreOverlay(),
                                                                            //   }
                                                                          },
                                                                        ),
                                                                        Container(
                                                                          alignment: Alignment.centerRight,
                                                                          child: SizedBox(
                                                                            height: 40,
                                                                            width: 110,
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                ref.read(optionsProvider.notifier).setWidgetOption('Videocall', user.role!);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                  side: const BorderSide(color: Colors.grey),
                                                                                ),
                                                                                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                                                              ),
                                                                              child: const Text(
                                                                                'Join',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : const Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Text(
                                                                          'The meeting is cancelled',
                                                                          style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                      const SizedBox(height: 30),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.white,
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
                                                const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "Schedule a video interview",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black, //                   <--- border color
                                                      width: 0.3,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Title',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                SizedBox(
                                                  height: 60,
                                                  child: TextField(
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                    controller: videoInterviewTitleController,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(9),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(9),
                                                        borderSide: const BorderSide(color: Colors.grey),
                                                      ),
                                                      contentPadding: const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 10,
                                                      ),
                                                      hintText: 'Enter video interview title',
                                                      hintStyle: const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(255, 114, 111, 111),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Start time',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 170,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          SizedBox(
                                                            height: 60,
                                                            child: TextField(
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 114, 111, 111),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              readOnly: true,
                                                              controller: dateControllerStart,
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
                                                                suffixIcon: InkWell(
                                                                  onTap: presentDatePickerStart,
                                                                  child: const Icon(Icons.calendar_month_outlined),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 170,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          SizedBox(
                                                            height: 60,
                                                            child: TextField(
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 114, 111, 111),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              readOnly: true,
                                                              controller: timeControllerStart,
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
                                                                suffixIcon: InkWell(
                                                                  onTap: presentTimePickerStart,
                                                                  child: const Icon(Icons.timer_sharp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'End time',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 170,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          SizedBox(
                                                            height: 60,
                                                            child: TextField(
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 114, 111, 111),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              readOnly: true,
                                                              controller: dateControllerEnd,
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
                                                                suffixIcon: InkWell(
                                                                  onTap: presentDatePickerEnd,
                                                                  child: const Icon(Icons.calendar_month_outlined),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 170,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          SizedBox(
                                                            height: 60,
                                                            child: TextField(
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 114, 111, 111),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              readOnly: true,
                                                              controller: timeControllerEnd,
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
                                                                suffixIcon: InkWell(
                                                                  onTap: presentTimePickerEnd,
                                                                  child: const Icon(Icons.timer_sharp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Duration: 60 minutes',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    // fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 80),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 46,
                                                      width: 175,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          videoInterviewTitleController.clear();
                                                          dateControllerStart.text = 'Select data';
                                                          timeControllerStart.text = 'Select time';
                                                          dateControllerEnd.text = 'Select data';
                                                          timeControllerEnd.text = 'Select time';

                                                          setState(() {
                                                            selectedDateStart = null;
                                                            selectedTimeStart = null;
                                                            selectedDateEnd = null;
                                                            selectedTimeEnd = null;
                                                          });
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
                                                          'Clear',
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
                                                        onPressed: () async {
                                                          print('------ video interview title -------');
                                                          print(videoInterviewTitleController.text);
                                                          print('------ start date -------');
                                                          print(selectedDateStart!.month);
                                                          print('------ start time -------');
                                                          print(selectedTimeStart);
                                                          print('start datetime');
                                                          print(
                                                            DateTime(
                                                              selectedDateStart!.year,
                                                              selectedDateStart!.month,
                                                              selectedDateStart!.day,
                                                              selectedTimeStart!.hour,
                                                              selectedTimeStart!.minute,
                                                            ).toString(),
                                                          );
                                                          print('------ end date -------');
                                                          print(selectedDateEnd);
                                                          print('------ end time -------');
                                                          print(selectedTimeEnd);
                                                          print('end datetime');
                                                          print(
                                                            DateTime(
                                                              selectedDateEnd!.year,
                                                              selectedDateEnd!.month,
                                                              selectedDateEnd!.day,
                                                              selectedTimeEnd!.hour,
                                                              selectedTimeEnd!.minute,
                                                            ).toString(),
                                                          );

                                                          //handle socket

                                                          print('------------ create interview -------------');

                                                          final socket = IO.io(
                                                              'https://api.studenthub.dev/', // Server url
                                                              OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

                                                          //Add authorization to header
                                                          socket.io.options?['extraHeaders'] = {
                                                            'Authorization': 'Bearer ${user.token}',
                                                          };

                                                          //Add query param to url
                                                          socket.io.options?['query'] = {'project_id': projectId};

                                                          socket.connect();

                                                          socket.onConnect((data) => {print('Connected')});
                                                          socket.onDisconnect((data) => {print('Disconnected')});

                                                          socket.onConnectError((data) => print('$data'));
                                                          socket.onError((data) => print(data));

                                                          //Listen for error from socket
                                                          socket.on("ERROR", (data) => print(data));

                                                          final Random random = Random();
                                                          int randomNumber = 0;
                                                          bool isExistRandomNumber = false;

                                                          do {
                                                            randomNumber = 1000000 + random.nextInt(900000);
                                                            print('------randomNumber------');
                                                            print(randomNumber);

                                                            final urlCheckAvailability = Uri.parse('${dotenv.env['IP_ADDRESS']}/meeting-room/check-availability?meeting_room_code=$randomNumber&meeting_room_id=$randomNumber');

                                                            final responseCheckAvailability = await http.get(
                                                              urlCheckAvailability,
                                                              headers: {
                                                                'Content-Type': 'application/json',
                                                                'Authorization': 'Bearer ${user.token}',
                                                              },
                                                            );

                                                            final responseCheckAvailabilityData = json.decode(responseCheckAvailability.body);
                                                            print('----responseMessagesData----');
                                                            print(responseCheckAvailabilityData);

                                                            if (responseCheckAvailabilityData['result']) {
                                                              isExistRandomNumber = true;
                                                            }
                                                          } while (isExistRandomNumber);

                                                          socket.emit(
                                                            "SCHEDULE_INTERVIEW",
                                                            {
                                                              "title": videoInterviewTitleController.text,
                                                              "content": "New interview was created",
                                                              "startTime": DateTime(
                                                                selectedDateStart!.year,
                                                                selectedDateStart!.month,
                                                                selectedDateStart!.day,
                                                                selectedTimeStart!.hour,
                                                                selectedTimeStart!.minute,
                                                              ).toString(),
                                                              "endTime": DateTime(
                                                                selectedDateEnd!.year,
                                                                selectedDateEnd!.month,
                                                                selectedDateEnd!.day,
                                                                selectedTimeEnd!.hour,
                                                                selectedTimeEnd!.minute,
                                                              ).toString(),
                                                              "projectId": projectId,
                                                              "senderId": user.id,
                                                              "receiverId": receiveId,
                                                              "meeting_room_code": randomNumber.toString(),
                                                              "meeting_room_id": randomNumber.toString(),
                                                            },
                                                          );

                                                          videoInterviewTitleController.clear();
                                                          dateControllerStart.text = 'Select data';
                                                          timeControllerStart.text = 'Select time';
                                                          dateControllerEnd.text = 'Select data';
                                                          timeControllerEnd.text = 'Select time';

                                                          setState(() {
                                                            selectedDateStart = null;
                                                            selectedTimeStart = null;
                                                            selectedDateEnd = null;
                                                            selectedTimeEnd = null;
                                                          });

                                                          Navigator.pop(context);
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
                                                          'Schedule',
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
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: const Icon(
                              Icons.calendar_month,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: sendMessage,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                suffixIcon: const Icon(Icons.emoji_emotions_outlined),
                                hintText: 'Type a message...',
                              ),
                            ),
                          ),
                          IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              final enterMessage = sendMessage.text;
                              print('------project id-------');
                              print(projectId);
                              print('------send id-------');
                              print(user.id);
                              print('------receive id-------');
                              print(receiveId);
                              if (enterMessage.trim().isEmpty) {
                                return;
                              }
                              print('------------chay dc o day-------------');

                              final socket = IO.io(
                                  'https://api.studenthub.dev/', // Server url
                                  OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

                              //Add authorization to header
                              socket.io.options?['extraHeaders'] = {
                                'Authorization': 'Bearer ${user.token}',
                              };

                              //Add query param to url
                              socket.io.options?['query'] = {'project_id': projectId};

                              socket.connect();

                              socket.onConnect((data) => {print('Connected')});
                              socket.onDisconnect((data) => {print('Disconnected')});

                              socket.onConnectError((data) => print('$data'));
                              socket.onError((data) => print(data));

                              //Listen for error from socket
                              socket.on("ERROR", (data) => print(data));
                              socket.emit("SEND_MESSAGE", {
                                "content": enterMessage,
                                "projectId": projectId,
                                "senderId": user.id,
                                "receiverId": receiveId,
                                "messageFlag": 0 // default 0 for message, 1 for interview
                              });

                              sendMessage.clear();
                            },
                            icon: const Icon(Icons.send),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
