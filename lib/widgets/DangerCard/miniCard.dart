// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MiniDangerCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const MiniDangerCard({super.key, required this.title, required this.onTap ,required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isSelected ? Colors.redAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    this.icon,
                    color: Colors.white,
                    size: 40,
                  ),
                  Text(
                    this.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          );
  }
}