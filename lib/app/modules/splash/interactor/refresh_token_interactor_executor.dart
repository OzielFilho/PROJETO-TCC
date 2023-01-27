import 'package:app/app/modules/splash/interactor/refresh_token_interactor_provider.dart';
import 'package:app/app/modules/splash/interactor/refresh_token_interactor_receiver.dart';
import 'package:app/app/modules/splash/models/user_logged_info_model.dart';
import 'package:app/app/modules/splash/repository/refresh_token_repository_firebase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../presenter/refresh_token_presenter_listener.dart';

class RefreshTokenInteractorExecutor
    implements RefreshTokenInteractorReceiver, RefreshTokenInteractorProvider {
  late RefreshTokenPresenterListener _listener;
  late FirebaseAuthService _authService;
  late FirestoreService _firestore;

  RefreshTokenInteractorExecutor(
      {required RefreshTokenPresenterListener listener,
      FirebaseAuthService? authService,
      FirestoreService? firestore})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._firestore = firestore ?? Modular.get<FirestoreServiceImpl>(),
        this._listener = listener;

  @override
  void handleLoggedUserException(Exception exception) {
    _listener.handleLoggedUserException(exception);
  }

  @override
  void loggedUserReceiver(UserLoggedInfoModel result) {
    _listener.loggedUserReceiver(result);
  }

  @override
  Future<void> verifyLoggedUser() async {
    final repository =
        RefreshTokenRepositoryFirebase(_authService, _firestore, this);
    await repository.execute();
  }
}
