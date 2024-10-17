import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget> actions;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    );
  }
}
