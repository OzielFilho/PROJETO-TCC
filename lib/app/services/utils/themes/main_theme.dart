import 'package:flutter/material.dart';
import 'appBar/app_bar_ligth.dart';
import 'banner/banner_main.dart';
import 'bottomNavigationBar/bottomNavigationBar_main.dart';
import 'bottom_app_bar/bottom_app_bar_main.dart';
import 'button/button_main.dart';
import 'buttonBar/buttonBar_main.dart';
import 'dialog/dialog_main.dart';
import 'floatingActionButton/floatingActionButton_main.dart';
import 'icon/icon_main.dart';
import 'pageTransitions/pageTransitions_main.dart';
import 'popupMenu/popupMenu_main.dart';
import 'snackBar/snackBar_main.dart';
import 'tabBar/tabBar_main.dart';
import 'text/text_main.dart';
import 'textButton/textButton_main.dart';
import 'card/card_main.dart';

class MainTheme {
  MainTheme();

  ThemeData get main => ThemeData(
        tabBarTheme: tabBarThememain,
        textButtonTheme: textButtonThememain,
        textTheme: textmain,
        bottomNavigationBarTheme: bottomNavigationBarThememain,
        floatingActionButtonTheme: floatingActionButtonThemeDatamain,
        iconTheme: iconThemeDatamain,
        brightness: Brightness.light,
        buttonTheme: buttonThemeDatamain,
        bottomAppBarTheme: bottomAppBarThememain,
        snackBarTheme: snackBarThemeDatamain,
        bannerTheme: bannerThemeDatamain,
        popupMenuTheme: popupMenuThemeDatamain,
        pageTransitionsTheme: pageTransitionsThememain,
        buttonBarTheme: buttonBarThemeDatamain,
        dialogTheme: dialogThememain,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: appBarLigth,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.grey,
        backgroundColor: Colors.white,
        cardTheme: cardmain,
      );
}
