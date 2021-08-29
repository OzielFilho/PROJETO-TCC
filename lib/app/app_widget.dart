import 'package:app/app/app_store.dart';
import 'package:app/app/services/utils/themes/dark_theme.dart';
import 'package:app/app/services/utils/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStore = Modular.get<AppStore>();
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: MainTheme().main,
      darkTheme: DarkTheme().dark,
      themeMode: appStore.themeActual,
      debugShowCheckedModeBanner: false,
    ).modular();
  }
}
