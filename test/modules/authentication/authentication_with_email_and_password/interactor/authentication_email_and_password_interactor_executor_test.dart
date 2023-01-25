import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/interactor/authentication_email_and_password_interactor_executor.dart';
import 'package:test/test.dart';

import '../../../../mocks/services/firebase_auth_service_mock_200.dart';
import '../../../../mocks/services/firebase_auth_service_mock_exception.dart';
import '../presenter/authentication_email_and_password_presenter_listener_mock.dart';

main() {
  FirebaseAuthService _authService;

  final _email = 'ozz@hotmail.com';
  final _password = '123456778';
  final _authenticationListener =
      AuthenticationEmailAndPasswordPresenterListenerMock();

  group('Authentication With Email And Password Executor Test', () {
    test('Authentication With Email And Password - Interactor - Success',
        () async {
      _authService = FirebaseAuthServiceMock200(mock: 'success');

      final authenticationEmailAndPassword =
          AuthenticationEmailAndPasswordInteractorExecutor(
              listener: _authenticationListener, authService: _authService);

      await authenticationEmailAndPassword.authenticationEmailAndPassword(
          email: _email, password: _password);

      expect(
          _authenticationListener.callsAuthenticationEmailAndPasswordReceiver,
          1);
    });

    test('Authentication With Email And Password - Interactor - Failure',
        () async {
      _authService = FirebaseAuthServiceMockException();

      final authenticationEmailAndPassword =
          AuthenticationEmailAndPasswordInteractorExecutor(
              listener: _authenticationListener, authService: _authService);

      await authenticationEmailAndPassword.authenticationEmailAndPassword(
          email: _email, password: _password);

      expect(
          _authenticationListener
              .callsHandleAuthenticationEmailAndPasswordException,
          1);
    });
  });
}
