import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationGoogleReceiver {
  Future<void> authenticationGoogleReceiver(User result);
  void handleAuthenticationGoogleException(Exception exception);
}
