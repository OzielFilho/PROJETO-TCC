import 'package:app/app/core/models/user_account.dart';

abstract class RefreshTokenPresenterListener {
  void loggedUserReceiver(UserAccount result);
  void handleLoggedUserException(Exception exception);
}
