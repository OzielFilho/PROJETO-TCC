import 'package:app/app/core/theme/theme_app.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class ButtonsDesign {
  static Widget buttonDefault(
      {required String text, required VoidCallback action}) {
    return MaterialButton(
      onPressed: action,
      color: ColorUtils.whiteColor,
      child: Text(
        text,
        style: ThemeApp.theme.textTheme.button,
      ),
    );
  }
}
