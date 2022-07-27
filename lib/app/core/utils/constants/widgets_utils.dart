import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';

class WidgetUtils {
  static showSnackBar(BuildContext context, String title,
      {required String? actionText, required VoidCallback? onTap}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(label: actionText!, onPressed: onTap!),
    ));
  }

  static showOkDialog(BuildContext context, String title, String message,
      String okButton, void Function() onOkPressed) {
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(title),
                content:
                    Text(message, style: ThemeApp.theme.textTheme.subtitle1),
                actions: [
                  TextButton(onPressed: onOkPressed, child: Text(okButton))
                ]);
          });
    });
  }
}
