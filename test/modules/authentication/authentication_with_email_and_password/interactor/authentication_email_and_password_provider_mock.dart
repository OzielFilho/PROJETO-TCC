import 'package:app/app/modules/authentication/authentication_email_and_password/interactor/authentication_email_and_password_provider.dart';

class AuthenticationEmailAndPasswordProviderMock
    implements AuthenticationEmailAndPasswordProvider {
  int callAuthenticationEmailAndPassword = 0;

  @override
  Future<void> authenticationEmailAndPassword(
      {required String email, required String password}) async {
    callAuthenticationEmailAndPassword += 1;
  }
}
