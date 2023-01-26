import 'package:app/app/modules/authentication/recovery_password/interactor/recovery_password_receiver.dart';

class RecoveryPasswordReceiverMock implements RecoveryPasswordReceiver {
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
