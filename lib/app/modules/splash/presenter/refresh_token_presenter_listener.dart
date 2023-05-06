import 'package:app/app/core/models/user_actual.dart';

abstract class RefreshTokenPresenterListener {
  void loggedUserReceiver(UserActual result);
  void handleLoggedUserException(Exception exception);
}
