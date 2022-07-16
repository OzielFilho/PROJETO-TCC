import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/app/modules/auth/infra/datasources/auth_user_datasource.dart';

class FirebaseAuthDatasourceImpl implements AuthUserDatasource {
  FirebaseAuth authClient;
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
}
