import 'package:app/app/modules/authentication/modules/authentication_google/interactor/authentication_google_provider.dart';
import 'package:firebase_auth_platform_interface/src/providers/oauth.dart';

class AuthenticationGoogleProviderMock implements AuthenticationGoogleProvider {
  int callAuthenticationGoogle = 0;

  @override
  Future<void> authenticationGoogle(OAuthCredential credential) async {
    callAuthenticationGoogle += 1;
  }
}
