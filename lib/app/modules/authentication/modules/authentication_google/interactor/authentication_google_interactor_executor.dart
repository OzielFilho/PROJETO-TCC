import 'package:app/app/modules/authentication/modules/authentication_google/interactor/authentication_google_provider.dart';
import 'package:app/app/modules/authentication/modules/authentication_google/interactor/authentication_google_receiver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/services/firebase_auth_service.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../../auth/domain/entities/auth_result.dart';
import '../../../../auth/infra/models/auth_result_model.dart';
import '../../../../auth/infra/models/user_create_google_model.dart';
import '../presenter/authentication_google_presenter_listener.dart';
import '../repository/authentication_google_firebase_repository.dart';

class AuthenticationGoogleInteractorExecutor
    implements AuthenticationGoogleProvider, AuthenticationGoogleReceiver {
  final AuthenticationGooglePresenterListener _listener;
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;

  AuthenticationGoogleInteractorExecutor(
      {FirebaseAuthService? authService,
      AuthenticationGooglePresenterListener? listener})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._firestoreService = Modular.get<FirestoreServiceImpl>(),
        this._listener = listener!;

  @override
  Future<void> authenticationGoogle(OAuthCredential credential) async {
    final repository =
        AuthenticationGoogleFirebaseRepository(_authService, this);
    await repository.execute(credential: credential);
  }

  @override
  Future<void> authenticationGoogleReceiver(User result) async {
    try {
      final existUser =
          await _firestoreService.existDocument('users', result.uid);

      if (!existUser) {
        await _firestoreService.createDocument('users', result.uid,
            UserCreateGoogleModel.fromUser(result).toMap());
        await _firestoreService
            .createDocument('chat', result.uid, {'contacts': []});
      }

      final user = await _firestoreService.getDocument('users', result.uid);
      AuthResult userResult = AuthResultModel.fromMap(user);
      if (!userResult.welcomePage) {
        _listener.authenticationGoogleReceiver('Welcome Page True');
      }
      _listener.authenticationGoogleReceiver('');
    } on Exception catch (exception) {
      _listener.handleAuthenticationGoogleException(exception);
    }
  }

  @override
  void handleAuthenticationGoogleException(Exception exception) {
    _listener.handleAuthenticationGoogleException(exception);
  }
}
