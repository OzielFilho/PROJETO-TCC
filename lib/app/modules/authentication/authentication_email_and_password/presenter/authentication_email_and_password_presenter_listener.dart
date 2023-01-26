import '../../enums/errors_enum_authentication.dart';

abstract class AuthenticationEmailAndPasswordPresenterListener {
  void handleAuthenticationEmailAndPasswordException(Exception exception);
  void authenticationEmailAndPasswordReceiver(EnumAuthentication result);
}
