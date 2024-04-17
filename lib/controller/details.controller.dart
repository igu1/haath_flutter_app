import 'package:disaster_management_app/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.controller.dart';

class DetailsController extends GetxController {
  final appC = Get.find<AppController>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final buttonEnabled = false.obs;

  void updateButton() {
    final String phoneNumber = phoneController.text;
    final String name = nameController.text;
    final String email = emailController.text;
    print("hello");
    final bool isValid =
        phoneNumber.isNotEmpty && name.isNotEmpty && email.isNotEmpty;
    buttonEnabled.value =
        isValid && phoneNumber.length >= 10 && name.length >= 3;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void submitForm() async {
    if (!buttonEnabled.value) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('phoneNumber', phoneController.text);
    final user = User(
      email: nameController.text,
      phonenumber: phoneController.text,
      name: nameController.text,
    );
    appC.currentUser(user);
    Get.toNamed("/loading");
  }
}
