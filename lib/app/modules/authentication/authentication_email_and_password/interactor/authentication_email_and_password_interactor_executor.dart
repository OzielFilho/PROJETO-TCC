import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/interactor/authentication_email_and_password_provider.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/interactor/authentication_email_and_password_receiver.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/repository/authentication_email_and_password_firebase_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/enums/errors_enum_authentication.dart';
import '../presenter/authentication_email_and_password_presenter_listener.dart';

class AuthenticationEmailAndPasswordInteractorExecutor
    implements
        AuthenticationEmailAndPasswordProvider,
        AuthenticationEmailAndPasswordReceiver {
  final AuthenticationEmailAndPasswordPresenterListener
      _authenticationEmailAndPasswordListener;
  final FirebaseAuthService _authService;

  AuthenticationEmailAndPasswordInteractorExecutor(
      {FirebaseAuthService? authService,
      AuthenticationEmailAndPasswordPresenterListener? listener})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._authenticationEmailAndPasswordListener = listener!;

  @override
  Future<void> authenticationEmailAndPassword(
      {required String email, required String password}) async {
    final _repository =
        AuthenticationEmailAndPasswordFirebaseRepository(_authService, this);
    await _repository.execute(email: email, password: password);
  }

  @override
  void authenticationEmailAndPasswordReceiver(String result) {
    if (result == 'Email não verificado! Verifique o email utilizar o app') {
      _authenticationEmailAndPasswordListener
          .authenticationEmailAndPasswordReceiver(
              EnumAuthentication.emailNotVerified);
      return;
    }
    if (result == 'Welcome Page True') {
      _authenticationEmailAndPasswordListener
          .authenticationEmailAndPasswordReceiver(
              EnumAuthentication.welcomePage);
      return;
    }
    if (result.isEmpty) {
      _authenticationEmailAndPasswordListener
          .authenticationEmailAndPasswordReceiver(EnumAuthentication.homePage);
      return;
    }
    _authenticationEmailAndPasswordListener
        .authenticationEmailAndPasswordReceiver(
            EnumAuthentication.defaultError);
  }

  @override
  void handleAuthenticationEmailAndPasswordException(Exception exception) {
    _authenticationEmailAndPasswordListener
        .handleAuthenticationEmailAndPasswordException(exception);
  }
}
