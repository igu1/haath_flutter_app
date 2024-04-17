// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:disaster_management_app/controller/app.controller.dart';
import 'package:disaster_management_app/controller/drop.mode.controller.dart';
import 'package:disaster_management_app/controller/sos.send.controller.dart';
import 'package:disaster_management_app/enum/SelectionType.dart';
import 'package:disaster_management_app/enum/UserTypes.dart';
import 'package:disaster_management_app/utils/locationUtils.dart';
import 'package:disaster_management_app/widgets/DangerCard/DangerCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:disaster_management_app/intialization/foregroundNotification.dart';
import 'package:hold_to_confirm_button/hold_to_confirm_button.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final selectionC = Get.put(DropModeController());
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    loadForegroundNotification();
  }

   void _handleTap(LatLng point) async {
      SelectionType type = selectionC.currentSelectionMethod.value;
      if (type == SelectionType.NONE) return;
      String iconString = selectionC.getIcon();
      BitmapDescriptor icon = await addCustomIcon(iconString);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: const InfoWindow(
          title: 'I am a marker',
        ),
        icon: icon,
      ));
    });
  }

  void _handleSOS() {
    final SOSController = Get.put(SOSService());
    Get.dialog(
        AlertDialog(
          content: Container(
            height: Get.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Are You Sure?", style: TextStyle(
                    fontSize: 25
                  ),),
                  Text("Are you Sure You want to send SOS message to everyone Near you?"),
                  HoldToConfirmButton(
                  onProgressCompleted: () {
                    Get.snackbar("SOS", "Don't worry, we are on it");
                      SOSController.isSOSsent = true;
                  },
                  hapticFeedback: false,
                  contentPadding: const EdgeInsets.all(50),
                  backgroundColor: SOSController.isSOSsent
                      ? const Color.fromARGB(255, 1, 74, 3)
                      : const Color.fromARGB(255, 174, 16, 5),
                  borderRadius: BorderRadius.circular(200),
                  child: const Icon(
                    Icons.sos_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                ],
              )
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final appC = Get.find<AppController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Let's Give", style: TextStyle(
                    fontSize: 30,
                  ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.notifications, color: Colors.black)),  
                      IconButton(onPressed: () => {
                        Get.toNamed('/news')
                      }, icon: Icon(Icons.newspaper, color: Colors.black)),
                    ],
                  )
                ],
              ),
              Text("H A A T H", style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900
              ),),
              SizedBox(height: 20,),
              DangerCard(),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Icon(Icons.announcement_outlined),
                    SizedBox(width: 10,),
                    Text(
                      'The Chance of Flood on Monday'
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 250,
                      width: Get.width * 0.9,
                    child: GoogleMap(
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      mapType: MapType.satellite,
                      zoomControlsEnabled: false,
                      markers: _markers.toSet(),
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 10),
                        zoom: 10,
                      ),
                      onTap: (latLag) => _handleTap(latLag),
                    ),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: Get.height * 0.17,
                width: Get.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(1, 0), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Humidity"),
                          Icon(
                            Icons.water_drop,
                            size: 30,
                          ),
                          Text("80%", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          )),

                        ],
                      ),
                    ),
                  );
                }, itemCount: 4,)
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: appC.currentUser.value?.userType == UserType.CITIZEN ? FloatingActionButton(
        onPressed: () {
            _handleSOS();      
        },
        
        tooltip: "Send SOS Messages To Everyone Near You",
        backgroundColor: Colors.redAccent.shade700,
        shape: CircleBorder(),
        child: Icon(Icons.sos, color: Colors.white,),
    
        ) : FloatingActionButton(
        onPressed: () async {
        },
        child: const Icon(Icons.edit, color: Colors.black),
      ),
    );
  }

}