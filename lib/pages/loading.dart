// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_management_app/controller/app.controller.dart';
import 'package:disaster_management_app/enum/UserTypes.dart';
import 'package:disaster_management_app/models/UserModel.dart';
import 'package:disaster_management_app/utils/pushNotification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPrecautions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> preString = prefs.getStringList('precautions') ?? [];
    if (preString.isNotEmpty) {
      return;
    }
    CollectionReference precautions =
        FirebaseFirestore.instance.collection('precautions');
    List<Object?> precautionsList = [];
    QuerySnapshot<Object?> querySnapshot = await precautions.get();
    for (var doc in querySnapshot.docs) {
      precautionsList.add(doc.data());
    }
    prefs.setStringList(
        'precautions', precautionsList.map((e) => jsonEncode(e)).toList());
  }

  Future<String> checkInDb_GetToken(
      String phoneNumber, String name, String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await users.doc(phoneNumber).get();
    PushNotificationService service = PushNotificationService();
    String? token = await service.getToken();
    if (!snapshot.exists) {
      users.doc(phoneNumber).set({
        'phoneNumber': phoneNumber,
        'name': name,
        'email': email,
        'fbToken': token
      });
    } else {
      snapshot.reference.update({'fbToken': token});
    }
    return token ?? '';
  }

  void setUser(String name, String email, String phoneNumber, UserType? userType) {
    final appC = Get.find<AppController>();
    appC.currentUser(User(name: name, email: email, phonenumber: phoneNumber, userType: userType ?? UserType.NONE));
    if (kDebugMode) {
      print("User Found, User Initilized");
    }
  }

  void _loadPreferences() async {

    



    final appC = Get.find<AppController>();
    final prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString('phoneNumber') ?? '';
    var name = prefs.getString('name') ?? '';
    var email = prefs.getString('email') ?? '';
    if (phoneNumber.isEmpty || name.isEmpty || email.isEmpty) {
      if (appC.isOnline.value) {
        Get.toNamed('/details');
      } else {
        Get.snackbar("Internet Connection Unavailable | Restart Your app",
            "Please connect to the internet to continue. (Only for First time)");
      }
      return;
    }

    var permissionAccess = prefs.getBool('permissionsGranted') ?? false;
    if (!permissionAccess) {
      if (appC.isOnline.value) {
        Get.toNamed('/permission');
      } else {
        Get.snackbar("Internet Connection Unavailable | Restart Your app",
            "Please connect to the internet to continue. (Only for First time)");
      }
      return;
    }


    var userType = prefs.getString('userType') ?? '';
    if (userType.isEmpty) {
      if (appC.isOnline.value) {
        if (appC.currentUser.value == null){
          setUser(name, email, phoneNumber, null);
        }
        Get.offAllNamed('/getUserType');
      } else {
        Get.snackbar("Internet Connection Unavailable | Restart Your app",
            "Please connect to the internet to continue. (Only for First time)");
      }
      return;
    }
    setUser(name, email, phoneNumber, UserType.values.firstWhere((element) => element.toString() == userType));
    await _loadPrecautions();
    String token = await checkInDb_GetToken(phoneNumber, name, email);
    if (token.isEmpty) {
      Get.snackbar('Firebase', "Firebase Token not Found. Restart Your App");
      return;
    } else {
      prefs.setString('fbToken', token);
    }
    Get.offAllNamed('/home');
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/loading.json'),
          const Text(
            "Setting Things Up...",
            style:
                TextStyle(fontSize: 20, fontFamily: 'Lexend', letterSpacing: 3),
          ),
        ],
      )),
    );
  }
}
