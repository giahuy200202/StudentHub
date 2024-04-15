import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/notifications/local_notification.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:studenthub/screens/layout.screen.dart';
import 'package:studenthub/utils/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

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
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const LayoutScreen(),
    );
  }
}
