// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MainBlackButton extends StatelessWidget {
  final title;
  final VoidCallback onTap;
  final bool buttonEnabled;
  final Size;
  const MainBlackButton({
    super.key,
    required this.onTap,
    required this.buttonEnabled,
    required this.title,
    this.Size
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    
        onPressed: buttonEnabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          fixedSize: Size,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
