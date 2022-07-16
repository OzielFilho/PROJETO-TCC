import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData get theme {
    return ThemeData(
        primaryColor: ColorUtils.primaryColor,
        backgroundColor: ColorUtils.primaryColor,
        buttonTheme: ButtonThemeData(buttonColor: ColorUtils.secondaryColor),
        scaffoldBackgroundColor: ColorUtils.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorUtils.secondaryColor,
        ));
  }
}
