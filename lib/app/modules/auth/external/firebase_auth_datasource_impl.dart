import 'package:app/app/modules/auth/infra/models/auth_result_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/app/modules/auth/infra/datasources/auth_user_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../domain/entities/auth_result.dart';

class FirebaseAuthDatasourceImpl implements AuthUserDatasource {
  final FirebaseAuth authClient;
  final GoogleSignIn googleSignIn;

  FirebaseAuthDatasourceImpl({
    required this.authClient,
    required this.googleSignIn,
  });

  @override
  Future<AuthResult> login(String email, String password) async {
    late AuthResult userResult;
    final user = await authClient.signInWithEmailAndPassword(
        email: email, password: password);
    userResult = AuthResultModel(user.user!.email!, user.user!.uid);
    return userResult;
  }

  @override
  Future<AuthResult> loginGoogle() async {
    late AuthResult userResult = AuthResultModel.empty();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await authClient.signInWithCredential(credential);

      userResult = AuthResultModel(
          userCredential.user!.email!, userCredential.user!.uid);
      return userResult;
    }
    return userResult;
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
