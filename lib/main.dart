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
  @override
  Widget build(BuildContext context) {
    final projectId = ref.watch(projectIdProvider);
    final user = ref.watch(userProvider);

    if (!listTriggeredSockerByProjectId.contains(projectId)) {
      listTriggeredSockerByProjectId.add(projectId);
      if (user.id != 0 && projectId != '') {
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

        //Listen to channel receive message
        socket.on(
          'RECEIVE_MESSAGE',
          (data) {
            // Your code to update ui

            print('------RECEIVE_MESSAGE------');
            print(data);

            if (mounted) {
              ref.read(messageProvider.notifier).pushMessageData(
                    DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(data['notification']['message']['createdAt']).toLocal()).toString(),
                    data['notification']['sender']['fullname'],
                    data['notification']['message']['content'],
                    false,
                    '',
                    '',
                    '',
                  );
              ref.read(notificationProvider.notifier).pushNotificationData(
                    data['notification']['id'].toString(),
                    '0',
                    data['notification']['message']['content'],
                    data['notification']['sender']['fullname'],
                    DateFormat("dd/MM/yyyy | HH:mm")
                        .format(
                          DateTime.parse(data['notification']['message']['createdAt']).toLocal(),
                        )
                        .toString(),
                  );

              if (data['notification']['sender']['id'] != user.id) {
                LocalNotifications.showSimpleNotification(
                  // id: tasks.length + 1,
                  title: 'You have a new message from ${data['notification']['sender']['fullname']}',
                  body: '${data['notification']['message']['content']}',
                  payload: 'data',
                );
              }
            }
          },
        );

        //Listen for error from socket
        socket.on("ERROR", (data) => print(data));

        //interview
        final socketInterview = IO.io(
            'https://api.studenthub.dev/', // Server url
            OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

        //Add authorization to header
        socketInterview.io.options?['extraHeaders'] = {
          'Authorization': 'Bearer ${user.token}',
        };

        //Add query param to url
        socketInterview.io.options?['query'] = {'project_id': projectId};

        socketInterview.connect();

        socketInterview.onConnect((data) => {print('Connected')});
        socketInterview.onDisconnect((data) => {print('Disconnected')});

        socketInterview.onConnectError((data) => print('$data'));
        socketInterview.onError((data) => print(data));

        //Listen to channel receive message
        socketInterview.on(
          'RECEIVE_INTERVIEW',
          (data) {
            // Your code to update ui

            print('------RECEIVE_INTERVIEW------');
            // print(data);

            print('------data[notification][interview][startTime]------');
            print(DateTime.parse(data['notification']['interview']['startTime']));
            print('------data[notification][interview][startTime].local------');
            print(DateTime.parse(data['notification']['interview']['startTime']).toLocal());
            if (mounted) {
              ref.read(messageProvider.notifier).pushMessageData(
                    DateFormat("dd/MM/yyyy | HH:mm").format(DateTime.parse(data['notification']['message']['createdAt']).toLocal()).toString(),
                    data['notification']['sender']['fullname'],
                    data['notification']['message']['content'],
                    true,
                    data['notification']['interview']['title'],
                    data['notification']['interview']['startTime'],
                    data['notification']['interview']['endTime'],
                  );
              ref.read(notificationProvider.notifier).pushNotificationData(
                    data['notification']['id'].toString(),
                    '0',
                    'You have a new interview schedule "${data['notification']['interview']['title']}"',
                    data['notification']['sender']['fullname'],
                    DateFormat("dd/MM/yyyy | HH:mm")
                        .format(
                          DateTime.parse(data['notification']['createdAt']).toLocal(),
                        )
                        .toString(),
                  );

              if (data['notification']['sender']['id'] != user.id) {
                LocalNotifications.showSimpleNotification(
                  // id: tasks.length + 1,
                  title: 'You have a new interview schedule created by ${data['notification']['sender']['fullname']}',
                  body: '${data['notification']['interview']['title']}',
                  payload: 'data',
                );
              }
            }
          },
        );

        //Listen for error from socket
        socketInterview.on("ERROR", (data) => print(data));
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
