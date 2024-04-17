import 'package:disaster_management_app/controller/sos.send.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hold_to_confirm_button/hold_to_confirm_button.dart';
import 'package:lottie/lottie.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  int counter = 0;
  bool isSOSsent = false;

  SOSService _sosController = Get.put(SOSService());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isSOSsent
                  ? Container()
                  : const Text(
                      "Emergency Help Needed?",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
              const SizedBox(
                height: 50,
              ),
              _sosController.isSOSsent
                  ? Column(
                    children: [
                      Lottie.asset('assets/sending.json', width: 200),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Don't worry, we are sending SMS to all the numbers you have in your app storage.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => Get.toNamed("/precautions"),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Safty Precautions",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Icon(
                                Icons.arrow_right,
                                color: Colors.red[300],
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                  : HoldToConfirmButton(
                      onProgressCompleted: () {
                        Get.snackbar("SOS", "Don't worry, we are on it");
                        setState(() {
                          _sosController.isSOSsent = true;
                          // _sosController.sendMultiSMS();
                        });
                      },
                      hapticFeedback: false,
                      contentPadding: const EdgeInsets.all(100),
                      backgroundColor: _sosController.isSOSsent
                          ? const Color.fromARGB(255, 1, 74, 3)
                          : const Color.fromARGB(255, 174, 16, 5),
                      borderRadius: BorderRadius.circular(200),
                      child: const Icon(
                        Icons.sos_outlined,
                        color: Colors.white,
                        size: 50,),),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
