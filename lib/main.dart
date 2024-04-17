// ignore_for_file: library_private_types_in_public_api

import 'package:disaster_management_app/controller/app.controller.dart';
import 'package:disaster_management_app/pages/Sos.dart';
import 'package:disaster_management_app/pages/News.dart';
import 'package:disaster_management_app/pages/get_details.dart';
import 'package:disaster_management_app/pages/get_user_type.dart';
import 'package:disaster_management_app/pages/home.dart';
import 'package:disaster_management_app/pages/loading.dart';
import 'package:disaster_management_app/pages/permission.dart';
import 'package:disaster_management_app/pages/precautions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: "AIzaSyAE-6xV3UHMTfi-nGj-VFYHElz3rB-fPos");
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<int, Widget> pages = {0: const Home(), 1: const News()};

  @override
  Widget build(BuildContext context) {
    AppController appC = Get.put(AppController());
    return GetMaterialApp(
      title: 'Haath',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading',
      getPages: [
        GetPage(name: '/loading', page: () => const LoadingPage()),
        GetPage(name: '/details', page: () => GetDetails()),
        GetPage(name: '/permission', page: () => const GetPermissions()),
        GetPage(name: '/getUserType', page: () => UserTypeSelection()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/sos', page: () => const SOS()),
        GetPage(name: '/precautions', page: () => const Precautions()),
        GetPage(name: '/news', page: () => const News()),
      ],
    );
  }
}
