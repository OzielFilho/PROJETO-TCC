import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/services/network_service.dart';
import '../presenter/recovery_password_presenter_listener.dart';
import '../repository/recovery_password_firebase_repository.dart';
import 'recovery_password_provider.dart';
import 'recovery_password_receiver.dart';

class RecoveryPasswordInteractorExecutor
    implements RecoveryPasswordProvider, RecoveryPasswordReceiver {
  final RecoveryPasswordPresenterListener _listener;
  final FirebaseAuthService _authService;
  final NetworkService _networkService;
  RecoveryPasswordInteractorExecutor(
      {FirebaseAuthService? authService,
      NetworkService? networkService,
      RecoveryPasswordPresenterListener? listener})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._listener = listener!,
        this._networkService =
            networkService ?? Modular.get<NetworkServiceImpl>();

  @override
  Future<void> recoveryPassword(String email) async {
    final repository =
        RecoveryPasswordFirebaseRepository(_authService, this, _networkService);
    await repository.execute(email: email);
  }

  @override
  void recoveryPasswordReceiver(bool result) {
    _listener.recoveryPasswordReceiver(result);
  }

  @override
  void handleRecoveryPasswordException(Exception exception) {
    _listener.handleRecoveryPasswordException(exception);
  }
}
