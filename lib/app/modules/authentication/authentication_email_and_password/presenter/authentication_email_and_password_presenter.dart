import 'dart:async';

import 'package:app/app/core/error/exceptions.dart';
import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/interactor/authentication_email_and_password_provider.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/presenter/authentication_email_and_password_presenter_listener.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/presenter/authentication_email_and_password_presenter_provider.dart';
import 'package:app/app/modules/authentication/routers/authentication_routable.dart';
import 'package:app/app/modules/authentication/routers/authentication_router.dart';
import 'package:flutter/material.dart';

import '../../enums/errors_enum_authentication.dart';
import '../interactor/authentication_email_and_password_interactor_executor.dart';
import '../models/authentication_params_model.dart';

class AuthenticationEmailAndPasswordPresenter extends ChangeNotifier
    implements
        AuthenticationEmailAndPasswordPresenterListener,
        AuthenticationEmailAndPasswordPresenterProvider {
  final _controllerStream = StreamController<Object>();
  late AuthenticationEmailAndPasswordProvider _provider;

  late AuthenticationRoutable _routable;
  BuildContext? _context;

  AuthenticationEmailAndPasswordPresenter(
      {AuthenticationEmailAndPasswordProvider? provider,
      BuildContext? context,
      AuthenticationRoutable? routable}) {
    this._routable = routable ?? AuthenticationRouter();
    this._context = context!;
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
  void authenticationEmailAndPasswordReceiver(EnumAuthentication result) {
    _controllerStream.sink.add(result);
    if (result == EnumAuthentication.homePage) {
      _routable.navigateToHomePage(context: _context!);
      return;
    }
    if (result == EnumAuthentication.emailNotVerified) {
      _routable.openDialogAuthentication(
          context: _context!,
          error: 'Email não verificado! Verifique o email utilizar o app');
      return;
    }
    if (result == EnumAuthentication.welcomePage) {
      _routable.navigateToWelcomePage(context: _context!);
      return;
    }
    _routable.openDialogAuthentication(
        context: _context!, error: 'Não foi possível realizar o login');
  }

  @override
  void handleAuthenticationEmailAndPasswordException(Exception exception) {
    _controllerStream.sink.add(exception);
    if (exception is EmailOrPasswordEmptyException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Email ou Senha estão vazios');
      return;
    }
    if (exception is EmailOrPasswordInvalidException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Email ou Senha são inválidos');
      return;
    }
    _routable.openDialogAuthentication(
        context: _context!, error: 'Não foi possível realizar o login');
  }

  @override
  Stream<Object> get outAuthController => _controllerStream.stream;

  @override
  void dispose() {
    super.dispose();
    _controllerStream.close();
  }
}
