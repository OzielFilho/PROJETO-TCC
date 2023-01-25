import 'package:app/app/modules/authentication/authentication_google/interactor/authentication_google_provider.dart';

class AuthenticationGoogleProviderMock implements AuthenticationGoogleProvider {
  int callAuthenticationGoogle = 0;

  @override
  Future<void> authenticationGoogle(dynamic credential) async {
    callAuthenticationGoogle += 1;
  }
}
