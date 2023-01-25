import 'package:flutter/material.dart';

abstract class AuthenticationRoutable {
  void openDialogError({required BuildContext context, required String error});
  void navigateToWelcomePage({required BuildContext context});
  void navigateToHomePage({required BuildContext context});
}
