import 'dart:io';

import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';

class FirebaseAuthServiceMockException implements FirebaseAuthService {
  dynamic mock;
  FirebaseAuthServiceMockException({mock}) : this.mock = mock ?? 'sucesso';

  int callSignInWithEmailAndPassword = 0;
  int callCreateAccount = 0;
  int callCreateUser = 0;
  int callGetToken = 0;
  int callRecoveryPassword = 0;
  int callSignInWithCredential = 0;
  int callSignOut = 0;
  int callUserLogged = 0;

  @override
  Future<String> createAccount(UserCreateAccountModel userModel, File? image) {
    callCreateAccount += 1;
    throw Exception();
  }

  @override
  Future<User> createUser(String email, String password) {
    callCreateUser += 1;
    // ignore: null_argument_to_non_null_type
    throw Exception();
  }

  @override
  Future<String> getToken() async {
    callGetToken += 1;
    throw Exception();
  }

  @override
  Future<void> recoveryPassword(String email) async {
    callRecoveryPassword += 1;
    throw Exception();
  }

  @override
  Future<User> signInWithCredential(credential) {
    callSignInWithCredential += 1;
    // ignore: null_argument_to_non_null_type
    throw Exception();
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) {
    callSignInWithEmailAndPassword += 1;
    throw Exception();
  }

  @override
  Future<void> signOut() async {
    callSignOut += 1;
    throw Exception();
  }

  @override
  Future<bool> userLogged() async {
    callUserLogged += 1;
    throw Exception();
  }
}
