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
import 'package:studenthub/screens/message/video_conference.screen.dart';
import 'package:studenthub/widgets/message/message_details.widget.dart';
import 'package:studenthub/widgets/message/body_message.widget.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/widgets/message/BottomSheet.widget.dart';
import 'package:studenthub/widgets/message/schedule.widget.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:studenthub/providers/language/language.provider.dart';
import 'package:studenthub/widgets/profile/profile_input_student_step1.widget.dart';
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
  final String idInterview;
  final int disableFlag;
  final String meetingRoomCode;

  Message({
    required this.createdAt,
    required this.author,
    required this.content,
    required this.isInterview,
    required this.titleInterview,
    required this.startTimeInterview,
    required this.endTimeInterview,
    required this.idInterview,
    required this.disableFlag,
    required this.meetingRoomCode,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : createdAt = json['createdAt'],
        author = json['author'],
        content = json['content'],
        isInterview = json['isInterview'],
        titleInterview = json['titleInterview'],
        startTimeInterview = json['startTimeInterview'],
        endTimeInterview = json['endTimeInterview'],
        idInterview = json['idInterview'],
        disableFlag = json['disableFlag'],
        meetingRoomCode = json['meetingRoomCode'];

  Map<dynamic, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'author': author,
      'content': content,
      'isInterview': isInterview,
      'titleInterview': titleInterview,
      'startTimeInterview': startTimeInterview,
      'endTimeInterview': endTimeInterview,
      'idInterview': idInterview,
      'disableFlag': disableFlag,
      'meetingRoomCode': meetingRoomCode,
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

  var videoInterviewTitleControllerEdit = TextEditingController();

  var dateControllerStartEdit = TextEditingController(text: 'Select Date');
  var timeControllerStartEdit = TextEditingController(text: 'Select Time');

  DateTime? selectedDateStartEdit;
  TimeOfDay? selectedTimeStartEdit;

  var dateControllerEndEdit = TextEditingController(text: 'Select Date');
  var timeControllerEndEdit = TextEditingController(text: 'Select Time');

  DateTime? selectedDateEndEdit;
  TimeOfDay? selectedTimeEndEdit;

  void setIsCancel(String interviewId, String userToken) async {
    final urlCancelInterview = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/interview/${interviewId}/disable');

    final responseCancelInterview = await http.patch(
      urlCancelInterview,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userToken}',
      },
    );

    final responseCancelInterviewData = json.decode(responseCancelInterview.body);
    print('----responseCancelInterviewData----');
    print(responseCancelInterviewData);
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
                '',
                1,
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
                item['interview']['id'].toString(),
                item['interview']['disableFlag'],
                item['interview']['meetingRoom']['meeting_room_code'],
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

    timeControllerStart.text = DateFormat('HH:mm')
        .format(DateTime(
          0,
          0,
          0,
          selectedTimeStart!.hour,
          selectedTimeStart!.minute,
        ))
        .toString();
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

    timeControllerEnd.text = DateFormat('HH:mm').format(DateTime(0, 0, 0, selectedTimeEnd!.hour, selectedTimeEnd!.minute)).toString();
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
    var colorApp = ref.watch(colorProvider);
    var Language = ref.watch(LanguageProvider);
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
        : Container(
            color: colorApp.colorBackgroundColor,
            child: SizedBox(
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Language.MessDetails,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: colorApp.colorTitle,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 660,
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
                                                            width: 310,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 160,
                                                                  child: Text(
                                                                    el.author,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                      color: colorApp.colorTitle,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  el.createdAt,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    color: colorApp.colorTime,
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
                                                            style: TextStyle(
                                                              color: colorApp.colorText,
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
                                                            width: 310,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 160,
                                                                  child: Text(
                                                                    el.author,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                      color: colorApp.colorTitle,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  el.createdAt,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    color: colorApp.colorTime,
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
                                                            //color: Colors.white,
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
                                                                    SizedBox(
                                                                      width: 140,
                                                                      child: Text(
                                                                        el.titleInterview,
                                                                        style: TextStyle(
                                                                          overflow: TextOverflow.ellipsis,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: colorApp.colorTitle,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    Text(
                                                                      '${DateTime.parse(el.endTimeInterview).difference(DateTime.parse(el.startTimeInterview)).inMinutes} minutes',
                                                                      style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: colorApp.colorTime,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(height: 20),
                                                                Text(
                                                                  '${Language.Stime}:  ${DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(el.startTimeInterview)).toString()}',
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: colorApp.colorText,
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 10),
                                                                Text(
                                                                  '${Language.Etime}:  ${DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(el.endTimeInterview)).toString()}',
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: colorApp.colorText,
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 20),
                                                                el.disableFlag == 0
                                                                    ? Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          PopupMenuButton<int>(
                                                                            iconColor: colorApp.colorIcon,
                                                                            itemBuilder: (context) => [
                                                                              PopupMenuItem<int>(
                                                                                  value: 0,
                                                                                  child: Text(
                                                                                    Language.Reschedule,
                                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                                                                  )),
                                                                              PopupMenuItem<int>(
                                                                                value: 1,
                                                                                child: Text(
                                                                                  Language.CancelMetting,
                                                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                            onSelected: (item) => {
                                                                              videoInterviewTitleControllerEdit.text = el.titleInterview,
                                                                              dateControllerStartEdit.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(el.startTimeInterview)).toString(),
                                                                              timeControllerStartEdit.text = DateFormat('HH:mm').format(DateTime.parse(el.startTimeInterview)).toString(),
                                                                              dateControllerEndEdit.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(el.endTimeInterview)).toString(),
                                                                              timeControllerEndEdit.text = DateFormat('HH:mm').format(DateTime.parse(el.endTimeInterview)).toString(),
                                                                              selectedDateStartEdit = DateTime.parse(el.startTimeInterview),
                                                                              selectedTimeStartEdit = TimeOfDay.fromDateTime(DateTime.parse(el.startTimeInterview)),
                                                                              selectedDateEndEdit = DateTime.parse(el.endTimeInterview),
                                                                              selectedTimeEndEdit = TimeOfDay.fromDateTime(DateTime.parse(el.endTimeInterview)),
                                                                              if (item == 0)
                                                                                {
                                                                                  showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    context: context,
                                                                                    backgroundColor: colorApp.colorBackgroundBootomSheet,
                                                                                    builder: (ctx) {
                                                                                      //edit
                                                                                      void presentDatePickerStartEdit() async {
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
                                                                                          selectedDateStartEdit = pickedDate;
                                                                                        });
                                                                                        dateControllerStartEdit.text = DateFormat('dd/MM/yyyy').format(selectedDateStartEdit!).toString();
                                                                                      }

                                                                                      void presentTimePickerStartEdit() async {
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
                                                                                          selectedTimeStartEdit = pickedTime;
                                                                                        });

                                                                                        timeControllerStartEdit.text = DateFormat('HH:mm').format(DateTime(0, 0, 0, selectedTimeStartEdit!.hour, selectedTimeStartEdit!.minute)).toString();
                                                                                      }

                                                                                      void presentDatePickerEndEdit() async {
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
                                                                                          selectedDateEndEdit = pickedDate;
                                                                                        });
                                                                                        dateControllerEndEdit.text = DateFormat('dd/MM/yyyy').format(selectedDateEndEdit!).toString();
                                                                                      }

                                                                                      void presentTimePickerEndEdit() async {
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
                                                                                          selectedTimeEndEdit = pickedTime;
                                                                                        });

                                                                                        timeControllerEndEdit.text = DateFormat('HH:mm').format(DateTime(0, 0, 0, selectedTimeEndEdit!.hour, selectedTimeEndEdit!.minute)).toString();
                                                                                      }

                                                                                      // videoInterviewTitleControllerEdit.text = el.titleInterview;
                                                                                      // dateControllerStartEdit.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(el.startTimeInterview)).toString();
                                                                                      // timeControllerStartEdit.text = DateFormat('HH:mm').format(DateTime.parse(el.startTimeInterview)).toString();
                                                                                      // dateControllerEndEdit.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(el.endTimeInterview)).toString();
                                                                                      // timeControllerEndEdit.text = DateFormat('HH:mm').format(DateTime.parse(el.endTimeInterview)).toString();
                                                                                      // selectedDateStartEdit = DateTime.parse(el.startTimeInterview);
                                                                                      // selectedTimeStartEdit = TimeOfDay.fromDateTime(DateTime.parse(el.startTimeInterview));
                                                                                      // selectedDateEndEdit = DateTime.parse(el.endTimeInterview);
                                                                                      // selectedTimeEndEdit = TimeOfDay.fromDateTime(DateTime.parse(el.endTimeInterview));

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
                                                                                                        Language.Reschedule,
                                                                                                        style: TextStyle(
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          color: colorApp.colorTitle,
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
                                                                                                    Text(
                                                                                                      Language.Title,
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        color: colorApp.colorTitle,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                      ),
                                                                                                    ),
                                                                                                    const SizedBox(height: 10),
                                                                                                    SizedBox(
                                                                                                      height: 60,
                                                                                                      child: TextField(
                                                                                                        style: TextStyle(fontSize: 16, color: colorApp.colorText),
                                                                                                        controller: videoInterviewTitleControllerEdit,
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
                                                                                                          hintText: Language.textSchedule,
                                                                                                          hintStyle: TextStyle(
                                                                                                            fontSize: 16,
                                                                                                            color: colorApp.colorText,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    const SizedBox(height: 10),
                                                                                                    Text(
                                                                                                      Language.Stime,
                                                                                                      style: TextStyle(
                                                                                                        color: colorApp.colorTitle,
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
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 16,
                                                                                                                    color: colorApp.colorText,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                  ),
                                                                                                                  readOnly: true,
                                                                                                                  controller: dateControllerStartEdit,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    border: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                      borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                                                                    ),
                                                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                                                      vertical: 0,
                                                                                                                      horizontal: 10,
                                                                                                                    ),
                                                                                                                    suffixIcon: InkWell(
                                                                                                                      onTap: presentDatePickerStartEdit,
                                                                                                                      child: Icon(
                                                                                                                        Icons.calendar_month_outlined,
                                                                                                                        color: colorApp.colorIcon,
                                                                                                                      ),
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
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 16,
                                                                                                                    color: colorApp.colorText,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                  ),
                                                                                                                  readOnly: true,
                                                                                                                  controller: timeControllerStartEdit,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    border: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                      borderSide: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                                                    ),
                                                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                                                      vertical: 0,
                                                                                                                      horizontal: 10,
                                                                                                                    ),
                                                                                                                    suffixIcon: InkWell(
                                                                                                                      onTap: presentTimePickerStartEdit,
                                                                                                                      child: Icon(
                                                                                                                        Icons.timer_sharp,
                                                                                                                        color: colorApp.colorIcon,
                                                                                                                      ),
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
                                                                                                    Text(
                                                                                                      Language.Etime,
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        color: colorApp.colorTitle,
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
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 16,
                                                                                                                    color: colorApp.colorText,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                  ),
                                                                                                                  readOnly: true,
                                                                                                                  controller: dateControllerEndEdit,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    border: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                      borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                                                                    ),
                                                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                                                      vertical: 0,
                                                                                                                      horizontal: 10,
                                                                                                                    ),
                                                                                                                    suffixIcon: InkWell(
                                                                                                                      onTap: presentDatePickerEndEdit,
                                                                                                                      child: Icon(
                                                                                                                        Icons.calendar_month_outlined,
                                                                                                                        color: colorApp.colorIcon,
                                                                                                                      ),
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
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 16,
                                                                                                                    color: colorApp.colorText,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                  ),
                                                                                                                  readOnly: true,
                                                                                                                  controller: timeControllerEndEdit,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    border: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(9),
                                                                                                                      borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                                                                    ),
                                                                                                                    contentPadding: const EdgeInsets.symmetric(
                                                                                                                      vertical: 0,
                                                                                                                      horizontal: 10,
                                                                                                                    ),
                                                                                                                    suffixIcon: InkWell(
                                                                                                                      onTap: presentTimePickerEndEdit,
                                                                                                                      child: Icon(
                                                                                                                        Icons.timer_sharp,
                                                                                                                        color: colorApp.colorIcon,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    const SizedBox(height: 110),
                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        SizedBox(
                                                                                                          height: 46,
                                                                                                          width: 175,
                                                                                                          child: ElevatedButton(
                                                                                                            onPressed: () {
                                                                                                              videoInterviewTitleControllerEdit.clear();
                                                                                                              dateControllerStartEdit.text = Language.selectdate;
                                                                                                              timeControllerStartEdit.text = Language.selecttime;
                                                                                                              dateControllerEndEdit.text = Language.selectdate;
                                                                                                              timeControllerEndEdit.text = Language.selecttime;

                                                                                                              setState(() {
                                                                                                                selectedDateStartEdit = null;
                                                                                                                selectedTimeStartEdit = null;
                                                                                                                selectedDateEndEdit = null;
                                                                                                                selectedTimeEndEdit = null;
                                                                                                              });
                                                                                                            },
                                                                                                            style: ElevatedButton.styleFrom(
                                                                                                              minimumSize: Size.zero, // Set this
                                                                                                              padding: EdgeInsets.zero, // and this
                                                                                                              shape: RoundedRectangleBorder(
                                                                                                                borderRadius: BorderRadius.circular(8),
                                                                                                                side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                                                                              ),
                                                                                                              backgroundColor: colorApp.colorButton,
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              Language.Clear,
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
                                                                                                          height: 46,
                                                                                                          width: 175,
                                                                                                          child: ElevatedButton(
                                                                                                            onPressed: () async {
                                                                                                              print('------ interview id ------');
                                                                                                              print(el.idInterview);
                                                                                                              print('------ Edit video interview title -------');
                                                                                                              print(videoInterviewTitleControllerEdit.text);
                                                                                                              print('------ Edit start date -------');
                                                                                                              print(selectedDateStartEdit);
                                                                                                              print('------ Edit start time -------');
                                                                                                              print(selectedTimeStartEdit);
                                                                                                              print('Edit start datetime');
                                                                                                              print(
                                                                                                                DateTime(
                                                                                                                  selectedDateStartEdit!.year,
                                                                                                                  selectedDateStartEdit!.month,
                                                                                                                  selectedDateStartEdit!.day,
                                                                                                                  selectedTimeStartEdit!.hour,
                                                                                                                  selectedTimeStartEdit!.minute,
                                                                                                                ).toString(),
                                                                                                              );
                                                                                                              print('------ end date -------');
                                                                                                              print(selectedDateEndEdit);
                                                                                                              print('------ end time -------');
                                                                                                              print(selectedTimeEndEdit);
                                                                                                              print('end datetime');
                                                                                                              print(
                                                                                                                DateTime(
                                                                                                                  selectedDateEndEdit!.year,
                                                                                                                  selectedDateEndEdit!.month,
                                                                                                                  selectedDateEndEdit!.day,
                                                                                                                  selectedTimeEndEdit!.hour,
                                                                                                                  selectedTimeEndEdit!.minute,
                                                                                                                ).toString(),
                                                                                                              );

                                                                                                              //handle socket

                                                                                                              print('------------ Edit interview -------------');

                                                                                                              final Random random = Random();

                                                                                                              final urlEditInterview = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/interview/${el.idInterview}');

                                                                                                              final responseEditInterview = await http.patch(
                                                                                                                urlEditInterview,
                                                                                                                headers: {
                                                                                                                  'Content-Type': 'application/json',
                                                                                                                  'Authorization': 'Bearer ${user.token}',
                                                                                                                },
                                                                                                                body: json.encode(
                                                                                                                  {
                                                                                                                    "title": videoInterviewTitleControllerEdit.text,
                                                                                                                    "startTime": DateTime(
                                                                                                                      selectedDateStartEdit!.year,
                                                                                                                      selectedDateStartEdit!.month,
                                                                                                                      selectedDateStartEdit!.day,
                                                                                                                      selectedTimeStartEdit!.hour,
                                                                                                                      selectedTimeStartEdit!.minute,
                                                                                                                    ).toString(),
                                                                                                                    "endTime": DateTime(
                                                                                                                      selectedDateEndEdit!.year,
                                                                                                                      selectedDateEndEdit!.month,
                                                                                                                      selectedDateEndEdit!.day,
                                                                                                                      selectedTimeEndEdit!.hour,
                                                                                                                      selectedTimeEndEdit!.minute,
                                                                                                                    ).toString(),
                                                                                                                  },
                                                                                                                ),
                                                                                                              );

                                                                                                              final responseEditInterviewData = json.decode(responseEditInterview.body);
                                                                                                              print('----responseEditInterviewData----');
                                                                                                              print(responseEditInterview);

                                                                                                              videoInterviewTitleControllerEdit.clear();
                                                                                                              dateControllerStartEdit.text = Language.selectdate;
                                                                                                              timeControllerStartEdit.text = Language.selecttime;
                                                                                                              dateControllerEndEdit.text = Language.selectdate;
                                                                                                              timeControllerEndEdit.text = Language.selecttime;

                                                                                                              setState(() {
                                                                                                                selectedDateStartEdit = null;
                                                                                                                selectedTimeStartEdit = null;
                                                                                                                selectedDateEndEdit = null;
                                                                                                                selectedTimeEndEdit = null;
                                                                                                              });

                                                                                                              Navigator.pop(context);
                                                                                                            },
                                                                                                            style: ElevatedButton.styleFrom(
                                                                                                              minimumSize: Size.zero, // Set this
                                                                                                              padding: EdgeInsets.zero, // and this
                                                                                                              shape: RoundedRectangleBorder(
                                                                                                                borderRadius: BorderRadius.circular(8),
                                                                                                              ),
                                                                                                              backgroundColor: colorApp.colorBlackWhite,
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              Language.Schedule,
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
                                                                                        );
                                                                                      });
                                                                                    },
                                                                                  )
                                                                                }
                                                                              else
                                                                                {
                                                                                  setIsCancel(el.idInterview, user.token!),
                                                                                }
                                                                            },
                                                                          ),
                                                                          Container(
                                                                            alignment: Alignment.centerRight,
                                                                            child: SizedBox(
                                                                              height: 40,
                                                                              width: 120,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => VideoConferencePage(
                                                                                        conferenceID: el.meetingRoomCode,
                                                                                        userId: user.id.toString(),
                                                                                        fullname: user.fullname!.length > 16 ? '${user.fullname!.substring(0, 16)}...' : user.fullname!,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    side: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                                  ),
                                                                                  backgroundColor: colorApp.colorBlackWhite,
                                                                                ),
                                                                                child: Text(
                                                                                  Language.Join,
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: colorApp.colorWhiteBlack,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            Language.textCancelmeeting,
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
                                                      Language.titleSchedule,
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
                                                  Text(
                                                    Language.Title,
                                                    style: TextStyle(
                                                      color: colorApp.colorTitle,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  SizedBox(
                                                    height: 60,
                                                    child: TextField(
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorApp.colorText,
                                                      ),
                                                      controller: videoInterviewTitleController,
                                                      // onChanged: (data) {
                                                      //   if (videoInterviewTitleController.text.isEmpty || dateControllerStart.text == 'Select Date' || dateControllerEnd.text == 'Select Date' || timeControllerStart.text == 'Select Time' || timeControllerEnd.text == 'Select Time') {
                                                      //     isFillShedule = false;
                                                      //   } else {
                                                      //     isFillShedule = true;
                                                      //   }
                                                      //   setState(() {});
                                                      // },
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(9),
                                                          borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                        ),
                                                        contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: 10,
                                                        ),
                                                        hintText: Language.textSchedule,
                                                        hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: colorApp.colorText,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    Language.Stime,
                                                    style: TextStyle(
                                                      color: colorApp.colorTitle,
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
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: colorApp.colorText,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                                readOnly: true,
                                                                controller: dateControllerStart,
                                                                // onChanged: (data) {
                                                                //   if (videoInterviewTitleController.text.isEmpty || dateControllerStart.text == 'Select Date' || dateControllerEnd.text == 'Select Date' || timeControllerStart.text == 'Select Time' || timeControllerEnd.text == 'Select Time') {
                                                                //     isFillShedule = false;
                                                                //   } else {
                                                                //     isFillShedule = true;
                                                                //   }
                                                                //   setState(() {});
                                                                // },
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                    borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                  ),
                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                    vertical: 0,
                                                                    horizontal: 10,
                                                                  ),
                                                                  suffixIcon: InkWell(
                                                                    onTap: presentDatePickerStart,
                                                                    child: Icon(
                                                                      Icons.calendar_month_outlined,
                                                                      color: colorApp.colorIcon,
                                                                    ),
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
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: colorApp.colorText,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                                readOnly: true,
                                                                controller: timeControllerStart,
                                                                // onChanged: (data) {
                                                                //   if (videoInterviewTitleController.text.isEmpty || dateControllerStart.text == 'Select Date' || dateControllerEnd.text == 'Select Date' || timeControllerStart.text == 'Select Time' || timeControllerEnd.text == 'Select Time') {
                                                                //     isFillShedule = false;
                                                                //   } else {
                                                                //     isFillShedule = true;
                                                                //   }
                                                                //   setState(() {});
                                                                // },
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                    borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                  ),
                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                    vertical: 0,
                                                                    horizontal: 10,
                                                                  ),
                                                                  suffixIcon: InkWell(
                                                                    onTap: presentTimePickerStart,
                                                                    child: Icon(
                                                                      Icons.timer_sharp,
                                                                      color: colorApp.colorIcon,
                                                                    ),
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
                                                  Text(
                                                    Language.Etime,
                                                    style: TextStyle(
                                                      color: colorApp.colorTitle,
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
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: colorApp.colorText,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                                readOnly: true,
                                                                controller: dateControllerEnd,
                                                                // onChanged: (data) {
                                                                //   if (videoInterviewTitleController.text.isEmpty || dateControllerStart.text == 'Select Date' || dateControllerEnd.text == 'Select Date' || timeControllerStart.text == 'Select Time' || timeControllerEnd.text == 'Select Time') {
                                                                //     isFillShedule = false;
                                                                //   } else {
                                                                //     isFillShedule = true;
                                                                //   }
                                                                //   setState(() {});
                                                                // },
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                    borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                  ),
                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                    vertical: 0,
                                                                    horizontal: 10,
                                                                  ),
                                                                  suffixIcon: InkWell(
                                                                    onTap: presentDatePickerEnd,
                                                                    child: Icon(
                                                                      Icons.calendar_month_outlined,
                                                                      color: colorApp.colorIcon,
                                                                    ),
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
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: colorApp.colorText,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                                readOnly: true,
                                                                controller: timeControllerEnd,
                                                                // onChanged: (data) {
                                                                //   if (videoInterviewTitleController.text.isEmpty || dateControllerStart.text == 'Select Date' || dateControllerEnd.text == 'Select Date' || timeControllerStart.text == 'Select Time' || timeControllerEnd.text == 'Select Time') {
                                                                //     isFillShedule = false;
                                                                //   } else {
                                                                //     isFillShedule = true;
                                                                //   }
                                                                //   setState(() {});
                                                                // },
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(9),
                                                                    borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                                  ),
                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                    vertical: 0,
                                                                    horizontal: 10,
                                                                  ),
                                                                  suffixIcon: InkWell(
                                                                    onTap: presentTimePickerEnd,
                                                                    child: Icon(
                                                                      Icons.timer_sharp,
                                                                      color: colorApp.colorIcon,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 110),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 46,
                                                        width: 175,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            videoInterviewTitleController.clear();
                                                            dateControllerStart.text = Language.selectdate;
                                                            timeControllerStart.text = Language.selecttime;
                                                            dateControllerEnd.text = Language.selectdate;
                                                            timeControllerEnd.text = Language.selecttime;

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
                                                              side: BorderSide(color: colorApp.colorBorderSideMutil as Color),
                                                            ),
                                                            backgroundColor: colorApp.colorButton,
                                                          ),
                                                          child: Text(
                                                            Language.Clear,
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
                                                              print('----responseCheckAvailabilityData----');
                                                              print(responseCheckAvailabilityData);

                                                              if (responseCheckAvailabilityData['result']) {
                                                                isExistRandomNumber = true;
                                                              } else {
                                                                isExistRandomNumber = false;
                                                              }
                                                            } while (isExistRandomNumber);

                                                            final urlScheduleInterview = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/interview');

                                                            final responseScheduleInterview = await http.post(
                                                              urlScheduleInterview,
                                                              headers: {
                                                                'Content-Type': 'application/json',
                                                                'Authorization': 'Bearer ${user.token}',
                                                              },
                                                              body: json.encode({
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
                                                              }),
                                                            );

                                                            final responseScheduleInterviewData = json.decode(responseScheduleInterview.body);
                                                            print('----responseScheduleInterviewData----');
                                                            print(responseScheduleInterviewData);

                                                            videoInterviewTitleController.clear();
                                                            dateControllerStart.text = Language.selectdate;
                                                            timeControllerStart.text = Language.selecttime;
                                                            dateControllerEnd.text = Language.selectdate;
                                                            timeControllerEnd.text = Language.selecttime;

                                                            setState(() {
                                                              selectedDateStart = null;
                                                              selectedTimeStart = null;
                                                              selectedDateEnd = null;
                                                              selectedTimeEnd = null;
                                                            });

                                                            // getMessages(user.token, projectId, receiveId);

                                                            Navigator.pop(context);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size.zero, // Set this
                                                            padding: EdgeInsets.zero, // and this
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            backgroundColor: colorApp.colorBlackWhite,
                                                          ),
                                                          child: Text(
                                                            Language.Schedule,
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
                                      );
                                    });
                                  },
                                );
                              },
                              child: Icon(
                                Icons.calendar_month,
                                size: 28,
                                color: colorApp.colorIcon,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: sendMessage,
                                style: TextStyle(fontSize: 16, color: colorApp.colorText),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: colorApp.colorIcon,
                                    ),
                                    hintText: Language.typemess,
                                    hintStyle: TextStyle(
                                      color: colorApp.colorText,
                                    )),
                              ),
                            ),
                            IconButton(
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () async {
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
                                print('------------send message api-------------');

                                final urlSendMessage = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/message/sendMessage');

                                final responseSendMessage = await http.post(
                                  urlSendMessage,
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${user.token}',
                                  },
                                  body: json.encode({
                                    "content": enterMessage,
                                    "projectId": projectId,
                                    "senderId": user.id,
                                    "receiverId": receiveId,
                                    "messageFlag": 0 // default 0 for message, 1 for interview
                                  }),
                                );

                                final responseSendMessageData = json.decode(responseSendMessage.body);
                                print('----responseSendMessageData----');
                                print(responseSendMessageData);

                                // ref.read(messageProvider.notifier).pushMessageData(
                                //       DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.now().toLocal()).toString(),
                                //       user.fullname!,
                                //       enterMessage,
                                //       false,
                                //       '',
                                //       '',
                                //       '',
                                //       '',
                                //       1,
                                //     );

                                sendMessage.clear();
                              },
                              icon: Icon(
                                Icons.send,
                                color: colorApp.colorIcon,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
