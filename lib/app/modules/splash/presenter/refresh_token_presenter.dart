import 'dart:async';

import 'package:app/app/core/error/exceptions.dart';
import 'package:app/app/modules/splash/interactor/refresh_token_interactor_provider.dart';
import 'package:app/app/modules/splash/models/user_logged_info_model.dart';
import 'package:app/app/modules/splash/presenter/refresh_token_presenter_listener.dart';
import 'package:app/app/modules/splash/presenter/refresh_token_presenter_provider.dart';
import 'package:app/app/modules/splash/routers/splash_router.dart';
import 'package:flutter/material.dart';

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

    if (exception is TokenInvalidException) {
      _routable.navigateToLoginPage(context: _context!);
      return;
    }
    _routable.openDialogSplash(
        context: _context!, error: 'Problemas ao acessar o aplicativo');
  }

  @override
  void loggedUserReceiver(UserLoggedInfoModel result) {
    _controller.sink.add(result);
    if (result.welcomePage) {
      _routable.navigateToWelcomePage(context: _context!);
      return;
    }
    if (!result.logged) {
      _routable.navigateToLoginPage(context: _context!);
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
