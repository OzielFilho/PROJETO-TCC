import 'dart:async';

import 'package:app/app/core/error/exceptions.dart';
import 'package:app/app/core/models/user_actual.dart';
import 'package:app/app/modules/splash/interactor/refresh_token_interactor_provider.dart';
import 'package:app/app/modules/splash/presenter/refresh_token_presenter_listener.dart';
import 'package:app/app/modules/splash/presenter/refresh_token_presenter_provider.dart';
import 'package:app/app/modules/splash/routers/splash_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../interactor/refresh_token_interactor_executor.dart';
import '../routers/splash_routable.dart';

class RefreshTokenPresenter extends ChangeNotifier
    implements RefreshTokenPresenterProvider, RefreshTokenPresenterListener {
  final _controller = StreamController<Object>();

  late RefreshTokenInteractorProvider _provider;
  late SplashRoutable _routable;
  BuildContext? _context;

  RefreshTokenPresenter({
    RefreshTokenInteractorProvider? provider,
    BuildContext? context,
  }) {
    _context = context;
    _routable = SplashRouter();
    _provider = provider ?? RefreshTokenInteractorExecutor(listener: this);
  }

  @override
  void handleLoggedUserException(Exception exception) {
    _controller.sink.add(exception);
    if (exception is NetworkException) {
      _routable.openDialogSplash(
        context: _context!,
        error: 'Sem conexão com a internet',
        callback: () {
          verifyLoggedUser();
          Modular.to.pop();
        },
      );
      return;
    }
    if (exception is TokenInvalidException) {
      _routable.navigateToLoginPage(context: _context!);
      return;
    }
    _routable.openDialogSplash(
        context: _context!,
        error: 'Problemas ao acessar o aplicativo',
        callback: () {
          verifyLoggedUser();
          Modular.to.pop();
        });
  }

  @override
  void loggedUserReceiver(UserActual result) {
    _controller.sink.add(result);

    if (!result.logged || result.token.isEmpty) {
      _routable.navigateToLoginPage(context: _context!);
      return;
    }
    String token = result.token;
    if (!result.welcomePage) {
      _routable.navigateToWelcomePage(context: _context!, refreshToken: token);
      return;
    }

    _routable.navigateToHomePage(context: _context!);
  }

  @override
  Stream<Object> get outRefreshToken => _controller.stream;

  @override
  Future<void> verifyLoggedUser() async {
    await _provider.verifyLoggedUser();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
