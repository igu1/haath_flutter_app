


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

void loadForegroundNotification(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? title = message.notification?.title;
      print('Notification Title: $title');
      String? body = message.notification?.body;
      Get.snackbar(title ?? '', body ?? '');
      return;
    });
  } 