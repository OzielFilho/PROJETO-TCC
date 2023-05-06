import 'package:app/app/core/models/user_account.dart';
import 'package:app/app/modules/splash/interactor/refresh_token_interactor_provider.dart';
import 'package:app/app/modules/splash/interactor/refresh_token_interactor_receiver.dart';
import 'package:app/app/modules/splash/repository/refresh_token_repository_firebase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/network_service.dart';
import '../presenter/refresh_token_presenter_listener.dart';

class RefreshTokenInteractorExecutor
    implements RefreshTokenInteractorReceiver, RefreshTokenInteractorProvider {
  late RefreshTokenPresenterListener _listener;
  late FirebaseAuthService _authService;
  late FirestoreService _firestore;
  final NetworkService _networkService;
  RefreshTokenInteractorExecutor(
      {required RefreshTokenPresenterListener listener,
      FirebaseAuthService? authService,
      NetworkService? networkService,
      FirestoreService? firestore})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._firestore = firestore ?? Modular.get<FirestoreServiceImpl>(),
        this._listener = listener,
        this._networkService =
            networkService ?? Modular.get<NetworkServiceImpl>();

  @override
  void handleLoggedUserException(Exception exception) {
    _listener.handleLoggedUserException(exception);
  }

  @override
  void loggedUserReceiver(Map<String, dynamic> result) {
    final user = UserAccount.fromJson(result);
    _listener.loggedUserReceiver(user);
  }

  @override
  Future<void> verifyLoggedUser() async {
    final repository = RefreshTokenRepositoryFirebase(
        _authService, _firestore, this, _networkService);
    await repository.execute();
  }
}
