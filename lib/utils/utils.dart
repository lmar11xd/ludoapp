import 'package:flutter/material.dart';
import 'package:ludo_app/enums/message_type.dart';
import 'package:ludo_app/utils/colors.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  MessageType type = MessageType.info,
}) {
  Color textColor = bgColor;
  Color backgroundColor = Colors.white;
  if (type == MessageType.success) {
    //Success
    textColor = Colors.white;
    backgroundColor = bgSuccess;
  } else if (type == MessageType.warning) {
    //Warning
    textColor = Colors.white;
    backgroundColor = bgWarning;
  } else if (type == MessageType.danger) {
    //Errror
    textColor = Colors.white;
    backgroundColor = bgDanger;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}

bool isEmail(String value) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return true;
  }
  return false;
}
