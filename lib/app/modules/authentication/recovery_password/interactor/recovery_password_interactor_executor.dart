import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../presenter/recovery_password_presenter_listener.dart';
import '../repository/recovery_password_firebase_repository.dart';
import 'recovery_password_provider.dart';
import 'recovery_password_receiver.dart';

class RecoveryPasswordInteractorExecutor
    implements RecoveryPasswordProvider, RecoveryPasswordReceiver {
  final RecoveryPasswordPresenterListener _listener;
  final FirebaseAuthService _authService;

  RecoveryPasswordInteractorExecutor(
      {FirebaseAuthService? authService,
      FirestoreService? firestoreService,
      RecoveryPasswordPresenterListener? listener})
      : this._authService =
            authService ?? Modular.get<FirebaseAuthServiceImpl>(),
        this._listener = listener!;

  @override
  Future<void> recoveryPassword(String email) async {
    final repository = RecoveryPasswordFirebaseRepository(_authService, this);
    await repository.execute(email: email);
  }

  @override
  Future<void> recoveryPasswordReceiver(bool result) async {
    _listener.recoveryPasswordReceiver(result);
  }

  @override
  void handleRecoveryPasswordException(Exception exception) {
    _listener.handleRecoveryPasswordException(exception);
  }
}
