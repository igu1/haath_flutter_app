import 'package:flutter/material.dart';

class UserTypeSelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool isSelected;
  
  const UserTypeSelectionCard({super.key, required this.title, required this.description,
   required this.onTap, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[100] : Color.fromARGB(255, 230, 229, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => {
                  onTap()
                  
                },
              ),
      ),
    );
  }
}