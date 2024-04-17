// ignore_for_file: prefer_const_constructors

import 'package:disaster_management_app/controller/drop.mode.controller.dart';
import 'package:disaster_management_app/controller/app.controller.dart';
import 'package:disaster_management_app/enum/UserTypes.dart';
import 'package:disaster_management_app/pages/loading.dart';
import 'package:disaster_management_app/widgets/UserTypeSelectionCard.dart';
import 'package:disaster_management_app/widgets/mainBlackButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeSelection extends StatefulWidget {
  UserTypeSelection({super.key});

  @override
  State<UserTypeSelection> createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection> {

  var selectedCard = UserType.NONE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Select Your User Type',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
                children: [
                  UserTypeSelectionCard(
                      title: "First Responder",
                      description:
                          'First Responders provide immediate assistance during emergencies, saving lives and ensuring public safety. (Police, Firefighters, Ambulances, etc.)',
                      onTap: () {
                        setState(() {
                          selectedCard = UserType.FIRST_RESPONDER;
                        });
                      },
                      isSelected: selectedCard == UserType.FIRST_RESPONDER),
                  const SizedBox(height: 20),
                  UserTypeSelectionCard(
                      title: "Citizen",
                      description:
                          'Citizens are essential in emergencies, calling for help, offering aid if possible, and supporting first responders for community safety.',
                      onTap: () {
                        setState(() {
                          selectedCard = UserType.CITIZEN;
                        });
                      },
                      isSelected: selectedCard == UserType.CITIZEN
                          ),
                  SizedBox(
                    height: 40,
                  ),
                  MainBlackButton(
                    Size: Size(200, 60),
                    onTap: () => {
                      if (selectedCard == UserType.NONE){
                          Get.snackbar(
                              "No User Type Selected", "Select Any User type..")
                        }
                        else{
                          Get.find<AppController>().updateUserType(selectedCard),
                          Get.offAllNamed('/loading')
                        }
                        
                    },
                    buttonEnabled:
                        selectedCard != UserType.NONE,
                    title: "Get Started",
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
