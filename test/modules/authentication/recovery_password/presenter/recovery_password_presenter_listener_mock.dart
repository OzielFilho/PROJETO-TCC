import 'package:app/app/modules/authentication/recovery_password/presenter/recovery_password_presenter_listener.dart';

class RecoveryPasswordPresenterListenerMock
    implements RecoveryPasswordPresenterListener {
  int callHandleRecoveryPasswordException = 0;
  int callRecoveryPasswordReceiver = 0;

  @override
  void handleRecoveryPasswordException(Exception exception) {
    callHandleRecoveryPasswordException += 1;
  }

  @override
  void recoveryPasswordReceiver(bool result) {
    callRecoveryPasswordReceiver += 1;
  }
}
