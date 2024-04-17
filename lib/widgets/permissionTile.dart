// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestTile extends StatelessWidget {
  final Permission permission;
  final String title;
  final String description;
  final bool isGranted;
  final VoidCallback onGranted;

  const PermissionRequestTile({
    super.key,
    required this.permission,
    required this.title,
    required this.description,
    required this.isGranted,
    required this.onGranted,
  });

  void _requestPermission(BuildContext context) async {
    var status = await permission.request();
    if (status.isGranted) {
      onGranted();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permission Denied'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isGranted
            ? Colors.green[100]
            : const Color.fromARGB(255, 230, 229, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: isGranted
            ? const Icon(Icons.check, color: Colors.green)
            : IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _requestPermission(context),
              ),
      ),
    );
  }
}
