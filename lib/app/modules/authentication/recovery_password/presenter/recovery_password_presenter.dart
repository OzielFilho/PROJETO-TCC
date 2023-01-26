import 'dart:async';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../routers/authentication_routable.dart';
import '../../routers/authentication_router.dart';
import '../interactor/recovery_password_interactor_executor.dart';
import '../interactor/recovery_password_provider.dart';
import 'recovery_password_presenter_listener.dart';
import 'recovery_password_presenter_provider.dart';

class RecoveryPasswordPresenter extends ChangeNotifier
    implements
        RecoveryPasswordPresenterListener,
        RecoveryPasswordPresenterProvider {
  final _controller = StreamController<Object>();
  late RecoveryPasswordProvider _provider;
  late AuthenticationRoutable _routable;
  BuildContext? _context;

  RecoveryPasswordPresenter(
      {RecoveryPasswordProvider? provider,
      BuildContext? context,
      AuthenticationRoutable? routable}) {
    this._routable = routable ?? AuthenticationRouter();
    this._context = context!;
    this._provider =
        provider ?? RecoveryPasswordInteractorExecutor(listener: this);
  }

  @override
  Future<void> recoveryPassword(String email) async {
    _controller.sink.add(ProcessingState());
    await _provider.recoveryPassword(email);
  }

  @override
  void recoveryPasswordReceiver(bool result) {
    _controller.sink.add(result);
  }

  @override
  void handleRecoveryPasswordException(Exception exception) {
    _controller.sink.add(exception);
    if (exception is EmailEmptyException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Email vazio');
      return;
    }
    if (exception is EmailInvalidException) {
      _routable.openDialogAuthentication(
          context: _context!, error: 'Email Inválido');
      return;
    }
    _routable.openDialogAuthentication(
        context: _context!, error: 'Não foi possível recuperar sua senha');
  }

  @override
  Stream<Object> get outRecoveryPasswordController => _controller.stream;

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}
