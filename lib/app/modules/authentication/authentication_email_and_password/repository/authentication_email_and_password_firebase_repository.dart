import 'dart:async';

import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/repository/authentication_email_and_password_executor.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/network_service.dart';
import '../interactor/authentication_email_and_password_receiver.dart';

class AuthenticationEmailAndPasswordFirebaseRepository
    implements AuthenticationEmailAndPasswordRepositoryExecutor {
  final FirebaseAuthService _authService;
  final AuthenticationEmailAndPasswordReceiver _receiver;
  final NetworkService _networkService;
  const AuthenticationEmailAndPasswordFirebaseRepository(
      this._authService, this._receiver, this._networkService);

  @override
  Future<void> execute(
      {required String email, required String password}) async {
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
      if (await _networkService.hasConnection) {
        final result =
            await _authService.signInWithEmailAndPassword(email, password);
        _receiver.authenticationEmailAndPasswordReceiver(result);
        UserAccount.instance.logged = true;
        return;
      }
      _receiver
          .handleAuthenticationEmailAndPasswordException(NetworkException());
    } on NetworkException catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    } on TimeoutException catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    } on FirebaseException catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    } on Exception catch (exception) {
      _receiver.handleAuthenticationEmailAndPasswordException(exception);
    }
  }
}
