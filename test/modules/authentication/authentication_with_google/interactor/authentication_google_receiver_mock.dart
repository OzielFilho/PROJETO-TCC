import 'package:app/app/modules/authentication/authentication_email_and_password/interactor/authentication_email_and_password_receiver.dart';

class AuthenticationEmailAndPasswordReceiverMock
    implements AuthenticationEmailAndPasswordReceiver {
  int callAuthenticationEmailAndPasswordReceiver = 0;
  int callHandleAuthenticationEmailAndPasswordException = 0;
  @override
  void authenticationEmailAndPasswordReceiver(String result) {
    callAuthenticationEmailAndPasswordReceiver += 1;
  }

  @override
  void handleAuthenticationEmailAndPasswordException(Exception exception) {
    callHandleAuthenticationEmailAndPasswordException += 1;
  }
}
