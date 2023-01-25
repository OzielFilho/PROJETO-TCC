import 'dart:async';

import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/error/exceptions.dart';
import '../interactor/authentication_google_receiver.dart';
import 'authentication_google_repository_executor.dart';

class AuthenticationGoogleFirebaseRepository
    implements AuthenticationGoogleRepositoryExecutor {
  final FirebaseAuthService _authService;
  final AuthenticationGoogleReceiver _receiver;

  const AuthenticationGoogleFirebaseRepository(
      this._authService, this._receiver);

  @override
  Future<void> execute({required OAuthCredential credential}) async {
    if (credential.asMap().isEmpty) {
      _receiver.handleAuthenticationGoogleException(CredentialEmptyException());
      return;
    }

    try {
      final result = await _authService.signInWithCredential(credential);
      _receiver.authenticationGoogleReceiver(result);
    } on TimeoutException catch (exception) {
      _receiver.handleAuthenticationGoogleException(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleAuthenticationGoogleException(exception);
    } on FirebaseException catch (exception) {
      _receiver.handleAuthenticationGoogleException(exception);
    } on Exception catch (exception) {
      _receiver.handleAuthenticationGoogleException(exception);
    }
  }
}
