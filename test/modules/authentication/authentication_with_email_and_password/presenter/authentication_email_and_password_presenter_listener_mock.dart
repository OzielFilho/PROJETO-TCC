import 'package:app/app/modules/authentication/modules/authentication_email_and_password/presenter/authentication_email_and_password_presenter_listener.dart';

class AuthenticationEmailAndPasswordPresenterListenerMock
    implements AuthenticationEmailAndPasswordPresenterListener {
  int callsAuthenticationEmailAndPasswordReceiver = 0;
  int callsHandleAuthenticationEmailAndPasswordException = 0;

  @override
  void authenticationEmailAndPasswordReceiver(String result) {
    callsAuthenticationEmailAndPasswordReceiver += 1;
  }

  @override
  void handleAuthenticationEmailAndPasswordException(Exception exception) {
    callsHandleAuthenticationEmailAndPasswordException += 1;
  }
}
