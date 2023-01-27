import 'package:app/app/modules/authentication/authentication_email_and_password/presenter/authentication_email_and_password_presenter_listener.dart';
import 'package:app/app/modules/authentication/utils/enums/errors_enum_authentication.dart';

class AuthenticationEmailAndPasswordPresenterListenerMock
    implements AuthenticationEmailAndPasswordPresenterListener {
  int callsAuthenticationEmailAndPasswordReceiver = 0;
  int callsHandleAuthenticationEmailAndPasswordException = 0;

  @override
  void authenticationEmailAndPasswordReceiver(EnumAuthentication result) {
    callsAuthenticationEmailAndPasswordReceiver += 1;
  }

  @override
  void handleAuthenticationEmailAndPasswordException(Exception exception) {
    callsHandleAuthenticationEmailAndPasswordException += 1;
  }
}
