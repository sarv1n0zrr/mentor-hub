import 'package:flutter/material.dart';

class ProfileMenuOption extends StatelessWidget {
  final IconData icon;
  final String text;
  // final Color color;

  const ProfileMenuOption({
    Key? key,
    required this.icon,
    required this.text,
    // required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white70,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }
}
