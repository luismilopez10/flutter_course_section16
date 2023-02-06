import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seccion16_pushnotifications/services/services.dart';

import 'screens/screens.dart';
import 'providers/theme_provider.dart';
import 'share_preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await PushNotificationService.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    PushNotificationService.messagesStream.listen((message) {
      // print('MyApp: $message');
      navigatorKey.currentState?.pushNamed(MessageScreen.routerName, arguments: message);

      messengerKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      navigatorKey: navigatorKey, // Para Navegar
      scaffoldMessengerKey: messengerKey, // Snackbars
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName: (_) => const HomeScreen(),
        MessageScreen.routerName: (_) => const MessageScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
