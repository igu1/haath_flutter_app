// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:disaster_management_app/controller/app.controller.dart';
import 'package:disaster_management_app/enum/DangerWarnings.dart';
import 'package:disaster_management_app/widgets/DangerCard/miniCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DangerCard extends StatelessWidget {
  const DangerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final appC = Get.find<AppController>();

    return Container(
      padding: EdgeInsets.all(10),
      height: 110,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(25)),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MiniDangerCard(title: 'Virus', onTap: () => appC.currentDangerWarning(DangerWarning.VIRUS), icon: Icons.bug_report, isSelected: appC.currentDangerWarning.value == DangerWarning.VIRUS,
          ),
          MiniDangerCard(title: 'Tsunami', onTap: () => appC.currentDangerWarning(DangerWarning.TSUNAMI), icon: Icons.tsunami, isSelected: appC.currentDangerWarning.value == DangerWarning.TSUNAMI,
          ),
          MiniDangerCard(title: 'Flood', onTap: () => appC.currentDangerWarning(DangerWarning.FLOOD), icon: Icons.flood, isSelected: appC.currentDangerWarning.value == DangerWarning.FLOOD,
          ),
          MiniDangerCard(title: 'Earth Quake', onTap: () => appC.currentDangerWarning(DangerWarning.EARTHQUAKE), icon: Icons.dangerous_outlined, isSelected: appC.currentDangerWarning.value == DangerWarning.EARTHQUAKE,),
        ],
      ),
    ));
  }
}
