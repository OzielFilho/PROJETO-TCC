import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/utils/widgets_utils.dart';
import 'authentication_routable.dart';

class AuthenticationRouter implements AuthenticationRoutable {
  @override
  void navigateToHomePage({required BuildContext context}) =>
      Modular.to.pushReplacementNamed('/home/');

  @override
  void navigateToWelcomePage({required BuildContext context}) =>
      Modular.to.pushReplacementNamed('/welcome/');

  @override
  void openDialogError({required BuildContext context, required String error}) {
    WidgetUtils.showOkDialog(
        context, 'Ops! Problema encontrado', error, 'Fechar', () {
      Modular.to.pop(context);
    }, permanentDialog: false);
  }
}
