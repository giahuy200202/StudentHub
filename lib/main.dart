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
  @override
  Widget build(BuildContext context) {
    final projectId = ref.watch(projectIdProvider);
    final user = ref.watch(userProvider);

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
