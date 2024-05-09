import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/notifications/local_notification.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/notification/messages.provider.dart';
import 'package:studenthub/providers/notification/notifications.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/screens/layout.screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotifications.init();
  tz.initializeTimeZones();
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  List<String> listTriggeredSockerByProjectId = [];
  List<String> listTriggeredSockerByUserId = [];
  bool isRunNotification = true;
  @override
  Widget build(BuildContext context) {
    final projectId = ref.watch(projectIdProvider);
    final user = ref.watch(userProvider);

    if (!listTriggeredSockerByProjectId.contains(projectId) || !listTriggeredSockerByUserId.contains(user.id.toString())) {
      listTriggeredSockerByProjectId.add(projectId);
      listTriggeredSockerByUserId.add(user.id.toString());

      if (user.id != 0) {
        if (isRunNotification) {
          print('------SOCKET NOTIFICATION------');
          final socket = IO.io(
            'https://api.studenthub.dev/', // Server url
            OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
          );

          //Add authorization to header
          socket.io.options?['extraHeaders'] = {
            'Authorization': 'Bearer ${user.token}',
          };

          //Add query param to url
          // socket.io.options?['query'] = {'project_id': projectId};

          socket.connect();

          socket.onConnect((data) => {print('Connected')});
          socket.onDisconnect((data) => {print('Disconnected')});

          socket.onConnectError((data) => print('$data'));
          socket.onError((data) => print(data));

          //Listen to channel receive message
          socket.on(
            'NOTI_${user.id}',
            (data) {
              // Your code to update ui

              print('------RECEIVE_NOTIFICATION------');
              print(data);

              if (mounted) {
                //submitted, offer
                print('------data[\'notification\'][\'typeNotifyFlag\']-----');
                print(data['notification']['typeNotifyFlag']);
                if (data['notification']['typeNotifyFlag'] == '2' || data['notification']['typeNotifyFlag'] == '0' || data['notification']['typeNotifyFlag'] == '4') {
                  print('------SUBMIT OFFER FLAG------');
                  ref.read(notificationProvider.notifier).pushNotificationData(
                        data['notification']['id'].toString(),
                        '0',
                        "${data['notification']['content']}",
                        data['notification']['sender']['fullname'],
                        DateFormat("dd/MM/yyyy | HH:mm")
                            .format(
                              DateTime.parse(data['notification']['proposal']['createdAt']).toLocal(),
                            )
                            .toString(),
                        data['notification']['typeNotifyFlag'].toString(),
                        data['notification']['typeNotifyFlag'] == '0' ? data['notification']['proposalId'].toString() : '',
                        data['notification']['typeNotifyFlag'] == '0' ? data['notification']['proposal']['coverLetter'] : '',
                        data['notification']['typeNotifyFlag'] == '0' ? data['notification']['proposal']['statusFlag'].toString() : '',
                      );
                  LocalNotifications.showSimpleNotification(
                    // id: tasks.length + 1,
                    title: '${data['notification']['title']}',
                    body: '${data['notification']['proposal']['coverLetter']}',
                    payload: 'data',
                  );
                } // interview
                else if (data['notification']['typeNotifyFlag'] == '1') {
                  print('------INTERVIEW FLAG------');

                  ref.read(notificationProvider.notifier).pushNotificationData(
                        data['notification']['id'].toString(),
                        '0',
                        '${data['notification']['content']}\nTitle: ${data['notification']['message']['interview']['title']}\nStart time: ${DateFormat("dd/MM/yyyy | HH:mm").format(
                              DateTime.parse(data['notification']['message']['interview']['startTime']),
                            ).toString()}\nEnd time: ${DateFormat("dd/MM/yyyy | HH:mm").format(
                              DateTime.parse(data['notification']['message']['interview']['endTime']),
                            ).toString()}\nMeeting room code: ${data['notification']['message']['interview']['meetingRoom']['meeting_room_code']}\nMeeting room id: ${data['notification']['message']['interview']['meetingRoomId']}',
                        data['notification']['sender']['fullname'],
                        DateFormat("dd/MM/yyyy | HH:mm")
                            .format(
                              DateTime.parse(data['notification']['message']['interview']['createdAt']).toLocal(),
                            )
                            .toString(),
                        data['notification']['typeNotifyFlag'].toString(),
                        '',
                        '',
                        '',
                      );
                  LocalNotifications.showSimpleNotification(
                    // id: tasks.length + 1,
                    title: '${data['notification']['content']}',
                    body: '${data['notification']['message']['interview']['title']}',
                    payload: 'data',
                  );
                } // chat
                else if (data['notification']['typeNotifyFlag'] == '3') {
                  print('------CHAT FLAG------');
                  ref.read(notificationProvider.notifier).pushNotificationData(
                        data['notification']['id'].toString(),
                        '0',
                        '${data['notification']['content']}\n${data['notification']['message']['content']}',
                        data['notification']['sender']['fullname'],
                        DateFormat("dd/MM/yyyy | HH:mm")
                            .format(
                              DateTime.parse(data['notification']['message']['createdAt']).toLocal(),
                            )
                            .toString(),
                        data['notification']['typeNotifyFlag'].toString(),
                        '',
                        '',
                        '',
                      );
                  LocalNotifications.showSimpleNotification(
                    // id: tasks.length + 1,
                    title: '${data['notification']['title']}',
                    body: '${data['notification']['message']['content']}',
                    payload: 'data',
                  );
                }
              }
            },
          );
          //Listen for error from socket
          socket.on("ERROR", (data) => print(data));
          setState(() {
            isRunNotification = false;
          });
        }

        if (projectId != '') {
          print('------SOCKET------');
          final socketMessageInterview = IO.io(
            'https://api.studenthub.dev/', // Server url
            OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
          );

          //Add authorization to header
          socketMessageInterview.io.options?['extraHeaders'] = {
            'Authorization': 'Bearer ${user.token}',
          };

          //Add query param to url
          socketMessageInterview.io.options?['query'] = {'project_id': projectId};

          socketMessageInterview.connect();

          socketMessageInterview.onConnect((data) => {print('Connected')});
          socketMessageInterview.onDisconnect((data) => {print('Disconnected')});

          socketMessageInterview.onConnectError((data) => print('$data'));
          socketMessageInterview.onError((data) => print(data));

          socketMessageInterview.on(
            'RECEIVE_MESSAGE',
            (data) {
              // Your code to update ui

              print('------RECEIVE_DATA------');
              print(data);

              if (mounted) {
                print('------RECEIVE_MESSAGE------');
                print(data);

                ref.read(messageProvider.notifier).pushMessageData(DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(data['notification']['message']['createdAt']).toLocal()).toString(), data['notification']['sender']['fullname'], data['notification']['message']['content'], false, '', '', '', '', 1, '');
              }
            },
          );

          socketMessageInterview.on(
            'RECEIVE_INTERVIEW',
            (data) {
              // Your code to update ui

              print('------RECEIVE_DATA------');
              print(data);

              if (mounted) {
                print('------RECEIVE_INTERVIEW------');
                ref.read(messageProvider.notifier).pushMessageData(
                      DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(data['notification']['message']['createdAt']).toLocal()).toString(),
                      data['notification']['sender']['fullname'],
                      data['notification']['message']['content'],
                      true,
                      data['notification']['message']['interview']['title'],
                      data['notification']['message']['interview']['startTime'],
                      data['notification']['message']['interview']['endTime'],
                      data['notification']['message']['interview']['id'].toString(),
                      data['notification']['message']['interview']['disableFlag'],
                      data['notification']['message']['interview']['meetingRoom']['meeting_room_code'],
                    );
              }
            },
          );

          socketMessageInterview.on("ERROR", (data) => print(data));
        }
      }
    }

    return MaterialApp(
      theme: ThemeData(
        // scaffoldBackgroundColor: Color.fromARGB(255, 40, 40, 40),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: const Color.fromARGB(255, 86, 85, 85),
          secondary: Colors.black,
        ),
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   /* dark theme settings */
      // ),
      home: const LayoutScreen(),
    );
  }
}
