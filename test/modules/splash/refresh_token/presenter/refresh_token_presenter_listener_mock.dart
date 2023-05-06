import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/modules/splash/presenter/refresh_token_presenter_listener.dart';

class RefreshTokenPresenterListenerMock
    implements RefreshTokenPresenterListener {
  int callHandleLoggedUserException = 0;
  int callLoggedUserReceiver = 0;

  @override
  void handleLoggedUserException(Exception exception) {
    callHandleLoggedUserException += 1;
  }

  @override
  void loggedUserReceiver(UserAccount result) {
    callLoggedUserReceiver += 1;
  }
}
