import 'dart:async';

import 'package:app/app/modules/splash/repository/refresh_token_repository_execute.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../interactor/refresh_token_interactor_receiver.dart';
import '../models/user_logged_info_model.dart';

class RefreshTokenRepositoryFirebase implements RefreshTokenRepositoryExecute {
  final FirebaseAuthService _authService;
  final FirestoreService _firestore;
  final RefreshTokenInteractorReceiver _receiver;

  RefreshTokenRepositoryFirebase(
      this._authService, this._firestore, this._receiver);

  @override
  Future<void> execute() async {
    try {
      final token = await _authService.getToken();
      if (token.isNotEmpty) {
        final user = await _firestore.getDocument('users', token);
        final logged = await _authService.userLogged();
        final result = UserLoggedInfoModel(
            logged: logged,
            welcomePage: user['welcome_page'] ?? user['welcomePage'],
            phone: user['phone']);
        _receiver.loggedUserReceiver(result);
        return;
      }
      _receiver.handleLoggedUserException(TokenInvalidException());
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
