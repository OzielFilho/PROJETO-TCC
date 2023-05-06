import 'package:app/app/modules/splash/interactor/refresh_token_interactor_receiver.dart';

class RefreshTokenInteractorReceiverMock
    implements RefreshTokenInteractorReceiver {
  int callHandleLoggedUserException = 0;
  int callLoggedUserReceiver = 0;
  @override
  void handleLoggedUserException(Exception exception) {
    callHandleLoggedUserException += 1;
  }

  @override
  void loggedUserReceiver(Map<String, dynamic> result) {
    callLoggedUserReceiver += 1;
  }
}
