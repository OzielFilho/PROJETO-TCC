import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/modules/authentication/recovery_password/interactor/recovery_password_interactor_executor.dart';
import 'package:test/test.dart';

import '../../../../mocks/services/firebase_auth_service_mock_200.dart';
import '../../../../mocks/services/firebase_auth_service_mock_exception.dart';
import '../../../../mocks/services/network_service_mock_200.dart';
import '../../../../mocks/services/network_service_mock_exception.dart';
import '../presenter/recovery_password_presenter_listener_mock.dart';

void main() {
  final _email = 'oziel@hotmail.com';
  FirebaseAuthService _authService;
  final _recoveryListener = RecoveryPasswordPresenterListenerMock();

  group('Recovery Password Executor Test', () {
    test('Recovery Password - Interactor - Success', () async {
      _authService = FirebaseAuthServiceMock200(mock: 'success');
      final networkService = NetworkServiceMock200();
      final recoveryPassword = RecoveryPasswordInteractorExecutor(
          listener: _recoveryListener,
          authService: _authService,
          networkService: networkService);

      await recoveryPassword.recoveryPassword(_email);

      expect(_recoveryListener.callRecoveryPasswordReceiver, 1);
    });

    test('Recovery Password - Interactor - Failure', () async {
      _authService = FirebaseAuthServiceMockException();
      final networkService = NetworkServiceMockException();
      final recoveryPassword = RecoveryPasswordInteractorExecutor(
          listener: _recoveryListener,
          authService: _authService,
          networkService: networkService);

      await recoveryPassword.recoveryPassword(_email);

      expect(_recoveryListener.callHandleRecoveryPasswordException, 1);
    });
  });
}
