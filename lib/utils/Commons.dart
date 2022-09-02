import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Commons {
/*
  * This method is used to print logs and toast messages
  * */
  static void toastMessage(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void toastMessage2(
    GlobalKey<ScaffoldState> scaffoldStateKey,
    String message, {
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    scaffoldStateKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void consoleLog(Object? str) {
    if (kDebugMode) {
      print(str);
    }
  }
}
