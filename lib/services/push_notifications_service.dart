// SHA1: 76:CB:4D:E5:8F:52:9A:FF:2D:56:98:CD:7B:A0:0A:3E:6C:9F:CD:FB
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print('onBackground Handler ${message.messageId}');

    _messageStream.add(message.data['product'] ?? 'No Data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler ${message.messageId}');
    print('${message.data}');

    _messageStream.add(message.data['product'] ?? 'No Data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp Handler ${message.messageId}');
    print('${message.data}');

    _messageStream.add(message.data['product'] ?? 'No Data');
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Mi Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler); // Cuando la app está cerrada pero aún corriendo
    FirebaseMessaging.onMessage.listen(_onMessageHandler); // Cuando la app está abierta
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp); // Cuando la app está terminada

    // Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}
