import 'dart:async';

import 'package:app/app/modules/splash/repository/refresh_token_repository_execute.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/network_service.dart';
import '../interactor/refresh_token_interactor_receiver.dart';

class RefreshTokenRepositoryFirebase implements RefreshTokenRepositoryExecute {
  final FirebaseAuthService _authService;
  final FirestoreService _firestore;
  final RefreshTokenInteractorReceiver _receiver;
  final NetworkService _networkService;
  RefreshTokenRepositoryFirebase(
      this._authService, this._firestore, this._receiver, this._networkService);

  @override
  Future<void> execute() async {
    try {
      if (await _networkService.hasConnection) {
        final token = await _authService.getToken();
        if (token.isNotEmpty) {
          final user = await _firestore.getDocument('users', token);
          final logged = await _authService.userLogged();

          user.addAll({'token': token});
          user.addAll({'logged': logged});

          _receiver.loggedUserReceiver(user);
          return;
        }
        _receiver.handleLoggedUserException(TokenInvalidException());
        return;
      }
      _receiver.handleLoggedUserException(NetworkException());
    } on NetworkException catch (exception) {
      _receiver.handleLoggedUserException(exception);
    } on TimeoutException catch (exception) {
      _receiver.handleLoggedUserException(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleLoggedUserException(exception);
    } on FirebaseException catch (exception) {
      _receiver.handleLoggedUserException(exception);
    } on Exception catch (exception) {
      _receiver.handleLoggedUserException(exception);
    }
  }
}
