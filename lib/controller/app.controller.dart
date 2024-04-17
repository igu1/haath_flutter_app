import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:disaster_management_app/enum/DangerWarnings.dart';
import 'package:disaster_management_app/enum/UserTypes.dart';
import 'package:disaster_management_app/models/UserModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  var isOnline = false.obs;

  final currentDangerWarning = Rxn<DangerWarning>();

  final currentUser = Rxn<User>();



  void updateUserType(type) async {
    currentUser.value?.userType = type;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userType', type.toString());
    update();
  }

  void setUserCitizen() {
    currentUser.value?.userType == UserType.CITIZEN;
    update();
  }

  void setUserFirstResponder() {
    currentUser.value?.userType == UserType.FIRST_RESPONDER;
    update();
  }

  @override
  void onInit() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result[0] == ConnectivityResult.none) {
        if (isOnline.value == false) return;
        isOnline.value = false;
        Get.offAllNamed("/sos");
        Get.snackbar("Internet Not Available", "No Internet Connection");
      } else {
        if (isOnline.value == true) return;
        isOnline.value = true;
        Get.offAllNamed("/loading");
        Get.snackbar("Internet Available", "Connected to Internet");
      }
      return;
    });
    super.onInit();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
