import '../utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData get theme {
    return ThemeData(
        primaryColor: ColorUtils.primaryColor,
        backgroundColor: ColorUtils.primaryColor,
        buttonTheme: ButtonThemeData(buttonColor: ColorUtils.whiteColor),
        scaffoldBackgroundColor: ColorUtils.primaryColor,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
            caption: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorUtils.whiteColor),
            overline: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: ColorUtils.whiteColor),
            subtitle1: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: ColorUtils.whiteColor),
            headline1: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorUtils.whiteColor),
            button: TextStyle(
                fontWeight: FontWeight.bold, color: ColorUtils.primaryColor)),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorUtils.secondaryColor,
        ));
  }
}
