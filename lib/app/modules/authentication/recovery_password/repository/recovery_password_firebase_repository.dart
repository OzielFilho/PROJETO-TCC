import 'dart:async';

import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions.dart';
import '../interactor/recovery_password_receiver.dart';
import 'recovery_password_repository_executor.dart';

class RecoveryPasswordFirebaseRepository
    implements RecoveryPasswordRepositoryExecutor {
  final FirebaseAuthService _authService;
  final RecoveryPasswordReceiver _receiver;

  const RecoveryPasswordFirebaseRepository(this._authService, this._receiver);

  @override
  Future<void> execute({required String email}) async {
    if (email.isEmpty) {
      _receiver.handleRecoveryPasswordException(EmailEmptyException());
      return;
    }
    if (!Validations.emailValidation(email: email)) {
      _receiver.handleRecoveryPasswordException(EmailInvalidException());
      return;
    }

    try {
      await _authService.recoveryPassword(email);
      _receiver.recoveryPasswordReceiver(true);
    } on TimeoutException catch (exception) {
      _receiver.handleRecoveryPasswordException(exception);
    } on FirebaseAuthException catch (exception) {
      _receiver.handleRecoveryPasswordException(exception);
    } on FirebaseException catch (exception) {
      _receiver.handleRecoveryPasswordException(exception);
    } on Exception catch (exception) {
      _receiver.handleRecoveryPasswordException(exception);
    }
  }
}
