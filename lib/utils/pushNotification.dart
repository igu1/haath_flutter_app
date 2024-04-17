// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';



class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

    });
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }
}
