import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const Alert(
      {super.key,
      required this.title,
      required this.desc,
      this.icon = Icons.warning_rounded});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
      ),
      content: Text(
        desc,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Ok'),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
      elevation: 10,
      icon: Icon(
        icon,
        color: icon == Icons.warning_rounded
            ? Colors.yellow.shade600
            : Colors.green.shade600,
        size: 30,
      ),
    );
  }
}
