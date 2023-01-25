import 'dart:async';

import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:app/app/modules/authentication/modules/authentication_email_and_password/repository/authentication_email_and_password_executor.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/error/exceptions.dart';
import '../interactor/authentication_email_and_password_receiver.dart';

class AuthenticationEmailAndPasswordFirebaseRepository
    implements AuthenticationEmailAndPasswordRepositoryExecutor {
  final FirebaseAuthService _authService;
  final AuthenticationEmailAndPasswordReceiver _receiver;

  const AuthenticationEmailAndPasswordFirebaseRepository(
      this._authService, this._receiver);

  @override
  Future<void> execute(
      {required String email, required String password}) async {
    print(
        'eh valid? ${(Validations.emailValidation(email: email) && Validations.passwordValidation(password: password))}');

    if (email.isEmpty || password.isEmpty) {
      _receiver.handleAuthenticationEmailAndPasswordException(
          EmailOrPasswordEmptyException());
      return;
    }

    if (!(Validations.emailValidation(email: email) &&
        Validations.passwordValidation(password: password))) {
      _receiver.handleAuthenticationEmailAndPasswordException(
          EmailOrPasswordInvalidException());
      return;
    }

    try {
      final result =
          await _authService.signInWithEmailAndPassword(email, password);
      _receiver.authenticationEmailAndPasswordReceiver(result);
    } on TimeoutException catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    }
  }
}
