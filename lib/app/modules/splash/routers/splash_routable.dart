import 'package:flutter/material.dart';

abstract class SplashRoutable {
  void openDialogSplash({required BuildContext context, required String error});
  void navigateToWelcomePage({required BuildContext context});
  void navigateToHomePage({required BuildContext context});
  void navigateToLoginPage({required BuildContext context});
}
