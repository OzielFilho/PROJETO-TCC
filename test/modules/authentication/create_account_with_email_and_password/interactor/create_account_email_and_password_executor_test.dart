import 'dart:io';

import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/network_service.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/interactor/create_account_with_email_and_password_executor.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';
import 'package:test/test.dart';

import '../../../../mocks/services/firebase_auth_service_mock_200.dart';
import '../../../../mocks/services/firebase_auth_service_mock_exception.dart';
import '../../../../mocks/services/network_service_mock_200.dart';
import '../../../../mocks/services/network_service_mock_exception.dart';
import '../presenter/create_account_email_and_password_presenter_listener_mock.dart';

void main() {
  FirebaseAuthService _authService;

  final _user = UserCreateAccountModel('name', 'oziel@hotmail.com', '123456',
      'faifnainfian', '123456', [], '(85)988714868', true);
  final _createAccountWithListener =
      CreateAccountWithEmailAndPasswordPresenterListenerMock();
  group('Create Account With With Email And Password Executor Test', () {
    test('Create Account With With Email And Password - Interactor - Success',
        () async {
      _authService = FirebaseAuthServiceMock200(mock: 'success');
      final networkService = NetworkServiceMock200();
      final createAccountEmailAndPassword =
          CreateAccountWithEmailAndPasswordExecutor(
              listener: _createAccountWithListener,
              authService: _authService,
              networkService: networkService);
      await createAccountEmailAndPassword.createAccount(
          _user, File('12345688'));

      expect(
          _createAccountWithListener
              .callsCreateAccountWithEmailAndPasswordReceiver,
          1);
    });

    test('Create Account With With Email And Password - Interactor - Failure',
        () async {
      _authService = FirebaseAuthServiceMockException();
      final networkService = NetworkServiceMockException();
      final createAccountEmailAndPassword =
          CreateAccountWithEmailAndPasswordExecutor(
              listener: _createAccountWithListener,
              authService: _authService,
              networkService: networkService);
      await createAccountEmailAndPassword.createAccount(
          _user, File('12345688'));
      expect(
          _createAccountWithListener
              .callsHandleCreateAccountWithEmailAndPasswordException,
          1);
    });
  });
}
