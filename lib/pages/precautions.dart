import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Precautions extends StatefulWidget {
  const Precautions({super.key});

  @override
  State<Precautions> createState() => _PrecautionsState();
}

class _PrecautionsState extends State<Precautions> {


  List<Map<String, dynamic>> precautions = []; 

  @override
  void initState() {
    super.initState();
    _loadPrecautions();
  }


  void _loadPrecautions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> preString = prefs.getStringList('precautions') ?? [];
    if (preString.isNotEmpty) {
      setState(() {
        precautions = preString
            .map((e) => jsonDecode(e) as Map<String, dynamic>)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Precautions"),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          Map<String, dynamic> precaution = precautions[index];
          return ExpansionTile(
              title: Text(precaution['title']),
              controlAffinity: ListTileControlAffinity.leading,
              collapsedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              subtitle: Text(precaution['subtitle']),
              tilePadding: const EdgeInsets.all(5),
              enableFeedback: false,
              children: [
                Text("""
                ${precaution['content']}
              """),
              ],
            );
        }, itemCount: precautions.length,));
  }
}
