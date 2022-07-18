import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/app/modules/auth/infra/datasources/auth_user_datasource.dart';

class FirebaseAuthDatasourceImpl implements AuthUserDatasource {
  FirebaseAuth authClient;

  /// ----------------------------------------
  /// [CALLED] --> GOOGLE CHANNEL INSTANCE
  /// IMPLEMENTS IN [loginGoogle]
  /// ----------------------------------------

  FirebaseAuthDatasourceImpl({
    required this.authClient,
  });

  @override
  Future<bool> login(String email, String password) async {
    try {
      final user = await authClient.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> loginGoogle(String idToken, String accessToken) {
    // TODO: implement loginGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> createUser(String email, String password) async {
    try {
      final user = await authClient.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> recoveryPassword(String email) async {
    try {
      await authClient.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }
}
