import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../routers/authentication_routable.dart';
import '../../routers/authentication_router.dart';
import '../interactor/authentication_google_interactor_executor.dart';
import '../interactor/authentication_google_provider.dart';
import 'authentication_google_presenter_listener.dart';
import 'authentication_google_presenter_provider.dart';

class AuthenticationGooglePresenter extends ChangeNotifier
    implements
        AuthenticationGooglePresenterListener,
        AuthenticationGooglePresenterProvider {
  final _controller = StreamController<Object>();
  late AuthenticationGoogleProvider _provider;
  late AuthenticationRoutable _routable;
  BuildContext? _context;

  AuthenticationGooglePresenter(
      {AuthenticationGoogleProvider? provider,
      BuildContext? context,
      AuthenticationRoutable? routable}) {
    this._routable = routable ?? AuthenticationRouter();
    this._context = context!;
    this._provider =
        provider ?? AuthenticationGoogleInteractorExecutor(listener: this);
  }

  @override
  Future<void> authenticationGoogle(dynamic credential) async {
    _controller.sink.add(ProcessingState());
    await _provider.authenticationGoogle(credential);
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
    _routable.openDialogAuthentication(
        context: _context!,
        error: 'Não foi possível realizar o login com sua conta google');
  }

  @override
  void handleAuthenticationGoogleException(Exception exception) {
    _controller.sink.add(exception);
    if (exception is NetworkException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Sem conexão com a internet');
      return;
    }
    if (exception is CredentialEmptyException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Credencial Inválida');
      return;
    }
    _routable.openDialogAuthentication(
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
