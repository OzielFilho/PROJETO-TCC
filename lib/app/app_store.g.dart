// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$isDarkAtom = Atom(name: '_AppStoreBase.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  final _$themeActualAtom = Atom(name: '_AppStoreBase.themeActual');

  @override
  ThemeMode get themeActual {
    _$themeActualAtom.reportRead();
    return super.themeActual;
  }

  @override
  set themeActual(ThemeMode value) {
    _$themeActualAtom.reportWrite(value, super.themeActual, () {
      super.themeActual = value;
    });
  }

  final _$valueSwitchAtom = Atom(name: '_AppStoreBase.valueSwitch');

  @override
  bool get valueSwitch {
    _$valueSwitchAtom.reportRead();
    return super.valueSwitch;
  }

  @override
  set valueSwitch(bool value) {
    _$valueSwitchAtom.reportWrite(value, super.valueSwitch, () {
      super.valueSwitch = value;
    });
  }

  final _$verificationThemeAsyncAction =
      AsyncAction('_AppStoreBase.verificationTheme');

  @override
  Future verificationTheme() {
    return _$verificationThemeAsyncAction.run(() => super.verificationTheme());
  }

  final _$saveThemeActualAsyncAction =
      AsyncAction('_AppStoreBase.saveThemeActual');

  @override
  Future saveThemeActual() {
    return _$saveThemeActualAsyncAction.run(() => super.saveThemeActual());
  }

  final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase');

  @override
  dynamic changeTheme(BuildContext context, bool value) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.changeTheme');
    try {
      return super.changeTheme(context, value);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ThemeMode getThemeActual() {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.getThemeActual');
    try {
      return super.getThemeActual();
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDark: ${isDark},
themeActual: ${themeActual},
valueSwitch: ${valueSwitch}
    ''';
  }
}
