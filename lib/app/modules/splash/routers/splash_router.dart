import 'package:app/app/modules/splash/routers/splash_routable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/utils/widgets_utils.dart';

class SplashRouter implements SplashRoutable {
  @override
  void navigateToHomePage({required BuildContext context}) =>
      Modular.to.pushReplacementNamed('/home/');

  @override
  void navigateToLoginPage({required BuildContext context}) =>
      Modular.to.pushReplacementNamed('/auth/');

  @override
  void navigateToWelcomePage({required BuildContext context}) =>
      Modular.to.pushReplacementNamed('/welcome/');

  @override
  void openDialogSplash(
      {required BuildContext context,
      required String error,
      required VoidCallback callback}) {
    WidgetUtils.showOkDialog(
        context, 'Ops! Problema encontrado', error, 'Fechar', callback,
        permanentDialog: false);
  }
}
