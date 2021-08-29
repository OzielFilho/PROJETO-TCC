import 'package:app/app/services/utils/themes/appBar/app_bar_dark.dart';
import 'package:flutter/material.dart';

import 'banner/banner_dark.dart';
import 'bottomNavigationBar/bottomNavigationBar_dark.dart';
import 'bottom_app_bar/bottom_app_bar_dark.dart';
import 'button/button_dark.dart';
import 'buttonBar/buttonBar_dark.dart';
import 'card/card_dark.dart';
import 'dialog/dialog_dark.dart';
import 'floatingActionButton/floatingActionButton_dark.dart';
import 'icon/icon_dark.dart';
import 'inputDecoration/input_decoration_dark.dart';
import 'pageTransitions/pageTransitions_dark.dart';
import 'popupMenu/popupMenu_dark.dart';
import 'snackBar/snackBar_dark.dart';
import 'tabBar/tabBar_dark.dart';
import 'text/text_dark.dart';
import 'textButton/textButton_dark.dart';

class DarkTheme {
  DarkTheme();

  ThemeData get dark => ThemeData(
      scaffoldBackgroundColor: Colors.grey[900],
      tabBarTheme: tabBarThemedark,
      textButtonTheme: textButtonThemedark,
      bottomNavigationBarTheme: bottomNavigationBarThemedark,
      floatingActionButtonTheme: floatingActionButtonThemeDatadark,
      iconTheme: iconThemeDatadark,
      buttonTheme: buttonThemeDatadark,
      bottomAppBarTheme: bottomAppBarThemedark,
      snackBarTheme: snackBarThemeDatadark,
      bannerTheme: bannerThemeDatadark,
      popupMenuTheme: popupMenuThemeDatadark,
      pageTransitionsTheme: pageTransitionsThemedark,
      buttonBarTheme: buttonBarThemeDatadark,
      dialogTheme: dialogThemedark,
      appBarTheme: appBarDark,
      cardTheme: carddark,
      primaryColor: Colors.orange,
      brightness: Brightness.dark,
      backgroundColor: Colors.grey[900],
      textTheme: textDark,
      accentColor: Colors.white,
      primaryColorDark: Colors.deepPurple,
      inputDecorationTheme: inputDecorationDark,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey[900],
          modalBackgroundColor: Colors.grey[900]));
}
