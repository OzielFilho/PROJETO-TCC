import '../models/user_logged_info_model.dart';

abstract class RefreshTokenInteractorReceiver {
  void loggedUserReceiver(UserLoggedInfoModel result);
  void handleLoggedUserException(Exception exception);
}
