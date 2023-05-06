import 'package:flutter/material.dart';

abstract class SplashRoutable {
  void openDialogSplash(
      {required BuildContext context,
      required String error,
      required VoidCallback callback});
  void navigateToWelcomePage(
      {required BuildContext context, required String refreshToken});
  void navigateToHomePage({required BuildContext context});
  void navigateToLoginPage({required BuildContext context});
}
