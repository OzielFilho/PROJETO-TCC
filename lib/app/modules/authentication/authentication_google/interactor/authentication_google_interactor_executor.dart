import 'package:app/app/core/services/network_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../models/auth_result_model.dart';
import '../models/user_create_google_model.dart';
import '../presenter/authentication_google_presenter_listener.dart';
import '../repository/authentication_google_firebase_repository.dart';
import 'authentication_google_provider.dart';
import 'authentication_google_receiver.dart';

class AuthenticationGoogleInteractorExecutor
    implements AuthenticationGoogleProvider, AuthenticationGoogleReceiver {
  final AuthenticationGooglePresenterListener _listener;
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;
  final NetworkService _networkService;
  AuthenticationGoogleInteractorExecutor(
      {FirebaseAuthService? authService,
      FirestoreService? firestoreService,
      NetworkService? networkService,
      AuthenticationGooglePresenterListener? listener})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._firestoreService =
            firestoreService ?? Modular.get<FirestoreServiceImpl>(),
        this._listener = listener!,
        this._networkService =
            networkService ?? Modular.get<NetworkServiceImpl>();

  @override
  Future<void> authenticationGoogle(dynamic credential) async {
    final repository = AuthenticationGoogleFirebaseRepository(
        _authService, this, _networkService);
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
      final userResult = AuthResultModel.fromMap(user);
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
