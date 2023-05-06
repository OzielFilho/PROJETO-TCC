import '../../../core/models/user_logged_response.dart';

abstract class RefreshTokenPresenterListener {
  void loggedUserReceiver(UserLoggedResponse result);
  void handleLoggedUserException(Exception exception);
}
