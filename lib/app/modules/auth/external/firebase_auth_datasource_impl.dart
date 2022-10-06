import 'package:app/app/modules/auth/infra/models/user_create_account_model.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestorage_service.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/utils/constants/encrypt_data.dart';
import '../domain/entities/auth_result.dart';
import '../infra/datasources/create_account_datasource.dart';
import '../infra/datasources/login_datasource.dart';
import '../infra/datasources/recovery_datasource.dart';
import '../infra/models/auth_result_model.dart';
import '../infra/models/user_create_google_model.dart';

class FirebaseAuthDatasourceImpl
    implements LoginDatasource, CreateAccountDatasource, RecoveryDatasource {
  final FirebaseAuthService authService;
  final GoogleSignIn googleSignIn;
  final FirestorageService firestorageService;
  final FirestoreService firestore;
  FirebaseAuthDatasourceImpl({
    required this.firestorageService,
    required this.authService,
    required this.googleSignIn,
    required this.firestore,
  });

  @override
  Future<AuthResult> loginWithEmailAndPassword(
      String email, String password) async {
    late AuthResult userResult;
    final userLogin =
        await authService.signInWithEmailAndPassword(email, password);
    final user = await firestore.getDocument('users', userLogin.uid);

    userResult = AuthResultModel.fromMap(user);
    return userResult;
  }

  @override
  Future<AuthResult> loginWithGoogle() async {
    late AuthResult userResult = AuthResultModel.empty();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final userCredential = await authService.signInWithCredential(credential);
      final existUser =
          await firestore.existDocument('users', userCredential.uid);

      if (!existUser) {
        await firestore.createDocument('users', userCredential.uid,
            UserCreateGoogleModel.fromUser(userCredential).toMap());
        await firestore
            .createDocument('chat', userCredential.uid, {'contacts': []});
      }

      final user = await firestore.getDocument('users', userCredential.uid);

      userResult = AuthResultModel.fromMap(user);
      return userResult;
    }
    return userResult;
  }

  @override
  Future<bool> recoveryWithEmail(String email) async {
    try {
      await authService.recoveryPassword(
        email,
      );
      return true;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> createWithEmailAndPassword(
      UserCreateAccountModel user, File? image) async {
    return await authService.createAccount(user, image);
  }
}
