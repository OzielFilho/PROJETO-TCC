import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  _AppStoreBase() {
    verificationTheme();
    var brightness = SchedulerBinding.instance?.window.platformBrightness;

    isDark = brightness == Brightness.dark ? true : false;
  }

  @observable
  bool isDark = false;

  @observable
  ThemeMode themeActual = ThemeMode.system;

  @observable
  bool valueSwitch = false;

  @action
  verificationTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isDark') != null) {
      valueSwitch = preferences.getBool('isDark')!;
      isDark = valueSwitch;
      if (valueSwitch) {
        themeActual = ThemeMode.dark;
      } else {
        themeActual = ThemeMode.light;
      }
    }
  }

  @action
  changeTheme(BuildContext context, bool value) {
    isDark = value;
    if (isDark && value) {
      themeActual = ThemeMode.dark;
    } else {
      themeActual = ThemeMode.light;
    }

    saveThemeActual();
  }

  @action
  saveThemeActual() async {
    SharedPreferences.getInstance().then((instance) {
      instance.setBool('isDark', isDark);
    });
  }

  @action
  ThemeMode getThemeActual() => themeActual;
}
