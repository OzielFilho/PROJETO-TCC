import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/modules/authentication_google/presenter/authentication_google_presenter_listener.dart';
import 'package:app/app/modules/authentication/modules/authentication_google/presenter/authentication_google_presenter_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../routers/authentication_routable.dart';
import '../../../routers/authentication_router.dart';
import '../interactor/authentication_google_interactor_executor.dart';
import '../interactor/authentication_google_provider.dart';

class AuthenticationGooglePresenter extends ChangeNotifier
    implements
        AuthenticationGooglePresenterListener,
        AuthenticationGooglePresenterProvider {
  final _controller = StreamController<Object>();
  late AuthenticationGoogleProvider _provider;
  late GoogleSignIn _googleSignIn;
  late AuthenticationRoutable _routable;
  BuildContext? _context;

  AuthenticationGooglePresenter(
      {AuthenticationGoogleProvider? provider,
      BuildContext? context,
      AuthenticationRoutable? routable}) {
    this._routable = routable ?? AuthenticationRouter();
    this._googleSignIn = GoogleSignIn();
    this._context = context!;
    this._provider =
        provider ?? AuthenticationGoogleInteractorExecutor(listener: this);
  }

  @override
  Future<void> authenticationGoogle() async {
    _controller.sink.add(ProcessingState());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await _provider.authenticationGoogle(credential);
      }
    } on Exception catch (exception) {
      _controller.sink.add(exception);
      _routable.openDialogError(
          context: _context!,
          error: 'Não foi possível realizar o login com sua conta google');
    }
  }

  @override
  void authenticationGoogleReceiver(String result) {
    _controller.sink.add(result);
    if (result.isEmpty) {
      _routable.navigateToHomePage(context: _context!);
      return;
    }
    if (result == 'Welcome Page True') {
      _routable.navigateToWelcomePage(context: _context!);
      return;
    }
    _routable.openDialogError(
        context: _context!,
        error: 'Não foi possível realizar o login com sua conta google');
  }

  @override
  void handleAuthenticationGoogleException(Exception exception) {
    _controller.sink.add(exception);
    if (exception is CredentialEmptyException) {
      _routable.openDialogError(
          context: _context!, error: 'Credencial Inválida');
      return;
    }
    _routable.openDialogError(
        context: _context!,
        error: 'Não foi possível realizar o login com sua conta google');
  }

  @override
  Stream<Object> get outGoogleLoginController => _controller.stream;

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}
