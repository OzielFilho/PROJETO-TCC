import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationGoogleProvider {
  Future<void> authenticationGoogle(OAuthCredential credential);
}
