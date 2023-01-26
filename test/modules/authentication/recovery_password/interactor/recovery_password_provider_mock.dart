import 'package:app/app/modules/authentication/recovery_password/interactor/recovery_password_provider.dart';

class RecoveryPasswordProviderMock implements RecoveryPasswordProvider {
  int callRecoveryPassword = 0;

  @override
  Future<void> recoveryPassword(String email) async {
    callRecoveryPassword += 1;
  }
}
