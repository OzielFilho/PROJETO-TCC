import 'dart:async';

import 'package:app/app/core/error/exceptions.dart';
import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/modules/authentication_email_and_password/interactor/authentication_email_and_password_provider.dart';
import 'package:app/app/modules/authentication/modules/authentication_email_and_password/presenter/authentication_email_and_password_presenter_listener.dart';
import 'package:app/app/modules/authentication/modules/authentication_email_and_password/presenter/authentication_email_and_password_presenter_provider.dart';
import 'package:app/app/modules/authentication/routers/authentication_routable.dart';
import 'package:app/app/modules/authentication/routers/authentication_router.dart';
import 'package:flutter/material.dart';

import '../interactor/authentication_email_and_password_interactor_executor.dart';
import '../models/authentication_params_model.dart';

class AuthenticationEmailAndPasswordPresenter extends ChangeNotifier
    implements
        AuthenticationEmailAndPasswordPresenterListener,
        AuthenticationEmailAndPasswordPresenterProvider {
  final _controllerStream = StreamController<Object>();
  late AuthenticationEmailAndPasswordProvider _provider;

  late AuthenticationRoutable _routable;
  late BuildContext _context;

  AuthenticationEmailAndPasswordPresenter(
      {AuthenticationEmailAndPasswordProvider? provider,
      required BuildContext context,
      AuthenticationRoutable? routable}) {
    this._routable = routable ?? AuthenticationRouter();
    this._context = context;
    this._provider = provider ??
        AuthenticationEmailAndPasswordInteractorExecutor(listener: this);
  }

  @override
  Future<void> authenticationEmailAndPassword(
      {required AuthenticationParamsModel params}) async {
    _controllerStream.sink.add(ProcessingState());
    await _provider.authenticationEmailAndPassword(
        email: params.email, password: params.password);
  }

  @override
  void authenticationEmailAndPasswordReceiver(String result) {
    _controllerStream.sink.add(result);
    if (result.isEmpty) {
      _routable.navigateToHomePage(context: _context);
      return;
    }
    if (result == 'Welcome Page True') {
      _routable.navigateToWelcomePage(context: _context);
      return;
    }
    _routable.openDialogError(
        context: _context, error: 'Não foi possível realizar o login');
  }

  @override
  void handleAuthenticationEmailAndPasswordException(Exception exception) {
    _controllerStream.sink.add(exception);
    if (exception is EmailOrPasswordEmptyException) {
      _routable.openDialogError(
          context: _context, error: 'Email ou Senha estão vazios');
      return;
    }
    if (exception is EmailOrPasswordInvalidException) {
      _routable.openDialogError(
          context: _context, error: 'Email ou Senha são inválidos');
      return;
    }
    _routable.openDialogError(
        context: _context, error: 'Não foi possível realizar o login');
  }

  @override
  Stream<Object> get outAuthController => _controllerStream.stream;

  @override
  void dispose() {
    super.dispose();
    _controllerStream.close();
  }
}
