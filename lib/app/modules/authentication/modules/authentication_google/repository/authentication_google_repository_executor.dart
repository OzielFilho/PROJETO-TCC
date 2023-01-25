import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationGoogleRepositoryExecutor {
  Future<void> execute({required OAuthCredential credential});
}
