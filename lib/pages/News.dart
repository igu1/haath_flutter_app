// ignore_for_file: prefer_const_constructors

import 'package:disaster_management_app/utils/pushNotification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class News extends StatelessWidget {
  const News({super.key});

  void _onItemTapped() async {
    PushNotificationService service = PushNotificationService();
    String? token = await service.getToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          SizedBox(
            height: Get.height,
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(1, 0), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "News $index",
                            style: const TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text("Readed", style: TextStyle(
                              color: Colors.white
                            ),),
                          )
                        ],
                      ),
                      Text("News Description $index", style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  IconButton(onPressed: () => {}, icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15,))
                ],
              ),
            );
          },
          itemCount: 10,
        ),
          )
    ]));
  }
}
