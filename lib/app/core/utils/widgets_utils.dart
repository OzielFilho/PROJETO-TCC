import 'colors/colors_utils.dart';
import 'package:flutter/material.dart';

import '../theme/theme_app.dart';

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
      String okButton, void Function() onOkPressed,
      {bool permanentDialog = true}) {
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
          barrierDismissible: permanentDialog,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: ColorUtils.secondaryColor,
                title: Text(title, style: ThemeApp.theme.textTheme.headline1),
                content:
                    Text(message, style: ThemeApp.theme.textTheme.subtitle1),
                actions: [
                  TextButton(
                      onPressed: onOkPressed,
                      child: Text(okButton,
                          style: ThemeApp.theme.textTheme.subtitle1))
                ]);
          });
    });
  }

  static showBottomSheetCustom(BuildContext context, String title,
      Widget? content, String okButton, void Function() onOkPressed,
      {bool permanentDialog = true}) {
    Future.delayed(Duration(milliseconds: 500), () {
      return showBottomSheet(
        context: context,
        backgroundColor: ColorUtils.transparentColor,
        builder: (context) {
          return Column(
            children: [
              Text(title, style: ThemeApp.theme.textTheme.headline1),
              TextButton(
                  onPressed: onOkPressed,
                  child:
                      Text(okButton, style: ThemeApp.theme.textTheme.subtitle1))
            ],
          );
        },
      );
    });
  }
}
