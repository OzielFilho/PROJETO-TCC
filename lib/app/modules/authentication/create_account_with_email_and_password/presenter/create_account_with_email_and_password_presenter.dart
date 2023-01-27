import 'dart:async';

import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';
import 'dart:io';

import 'package:app/app/modules/authentication/create_account_with_email_and_password/presenter/create_account_with_email_and_password_presenter_listener.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/presenter/create_account_with_email_and_password_presenter_provider.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/presentation/controller/app_state.dart';
import '../../routers/authentication_routable.dart';
import '../../routers/authentication_router.dart';
import '../interactor/create_account_with_email_and_password_executor.dart';
import '../interactor/create_account_with_email_and_password_provider.dart';

class CreateAccountWithEmailAndPasswordPresenter extends ChangeNotifier
    implements
        CreateAccountWithEmailAndPasswordPresenterListener,
        CreateAccountWithEmailAndPasswordPresenterProvider {
  final _controller = StreamController<Object>();
  late CreateAccountWithEmailAndPasswordProvider _provider;
  late AuthenticationRoutable _routable;
  BuildContext? _context;

  CreateAccountWithEmailAndPasswordPresenter(
      {CreateAccountWithEmailAndPasswordProvider? provider,
      BuildContext? context,
      AuthenticationRoutable? routable}) {
    this._routable = routable ?? AuthenticationRouter();
    this._context = context!;
    this._provider =
        provider ?? CreateAccountWithEmailAndPasswordExecutor(listener: this);
  }

  @override
  Future<void> createAccount(
      UserCreateAccountModel userCreateAccountModel, File? image) async {
    _controller.sink.add(ProcessingState());
    await _provider.createAccount(userCreateAccountModel, image);
  }

  @override
  void createdAccountReceiver(String result) {
    _controller.sink.add(result);
  }

  @override
  void handleCreateAccountExceptionReceiver(Exception exception) {
    _controller.sink.add(exception);

    if (exception is NetworkException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Sem conexão com a internet');
      return;
    }

    if (exception is ParamsEmptyUserException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Alguma informação está vazia');
      return;
    }

    if (exception is ParamsInvalidUserException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Alguma informação está inválida');
      return;
    }
    if (exception is PasswordAndConfirmePasswordDifferenceException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Senhas não correspondem');
      return;
    }
    if (exception is PhoneInvalidException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Telefone inserido é inválido');
      return;
    }

    _routable.openDialogAuthentication(
        context: _context!,
        error:
            'Não foi possível realizar o cadastro de sua conta. Tente novamente');
  }

  @override
  Stream<Object> get outCreateAccountController => _controller.stream;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
