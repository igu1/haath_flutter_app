// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, library_private_types_in_public_api
import 'package:disaster_management_app/widgets/permissionTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class GetPermissions extends StatefulWidget {
  const GetPermissions({super.key});

  @override
  _GetPermissionsState createState() => _GetPermissionsState();
}

class _GetPermissionsState extends State<GetPermissions> {
  bool locationPermissionGranted = false;
  bool notificationPermissionGranted = false;

  void _updatePermissionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (locationPermissionGranted && notificationPermissionGranted) {
        await prefs.setBool('permissionsGranted', true);
        Get.toNamed("/loading");  
      }
    } catch (e) {
      Get.snackbar('Error', "Permission not granted");
    }
  }


  @override
  void initState() {
    _updatePermissionStatus();
    super.initState();
  }

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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'We need your permission to continue',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lexend',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
              SizedBox(height: 20),
              PermissionRequestTile(permission: Permission.location,
              title: 'Location',
              description: "We need your permission to access your location. For Sending SOS For First Responders",
              isGranted: locationPermissionGranted,
              onGranted: () => {
                setState(() {
                  locationPermissionGranted = true;
                }),
                                _updatePermissionStatus()
              }),
              SizedBox(height: 20),
              PermissionRequestTile(
                permission: Permission.notification,
                title: 'Notification',
                description:
                    "We need your permission to access your notifications. For notifiying the disaster alerts and more",
                isGranted: notificationPermissionGranted,
                onGranted: () => {
                      setState(() {
                        notificationPermissionGranted = true;
                      }),
                      _updatePermissionStatus()
                    }),
            ],
          ),
        ),
      );
  }
}