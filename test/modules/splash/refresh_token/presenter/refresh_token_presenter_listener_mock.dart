import 'package:app/app/modules/splash/models/user_logged_info_model.dart';
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
  void loggedUserReceiver(UserLoggedInfoModel result) {
    callLoggedUserReceiver += 1;
  }
}
