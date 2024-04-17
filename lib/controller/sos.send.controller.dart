import 'package:get/get.dart';

class SOSService extends GetxController {

  bool isSOSsent = false;

  final numbers = [];

  bool isSOSSendToNumber(String number) {
    if (numbers.contains(number)) {
      return true;
    } else {
      return false;
    }
  }


  // Future<String> sendMultiSMS() async {
  //   String result = await sendSMS(
  //           message: 'Hello', recipients: ['+917306096088'], sendDirect: true)
  //       .catchError((onError) {
  //     Get.snackbar("Error", 'Failed to send SMS: $onError');
  //     return '';
  //   });
  //   return result;
  // }


  void addNumber(String number) {
    numbers.add(number);
  }

}