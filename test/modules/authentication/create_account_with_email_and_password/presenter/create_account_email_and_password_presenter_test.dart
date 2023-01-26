import 'dart:io';

import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/presenter/create_account_with_email_and_password_presenter.dart';
import 'package:test/test.dart';

import '../../../../mocks/build_context_mock.dart';
import '../interactor/create_account_email_and_password_provider_mock.dart';

void main() {
  final _user = UserCreateAccountModel('name', 'oziel@hotmail.com', '123456',
      'faifnainfian', '123456', [], '(85)988714868', true);

  final _result = 'Welcome Page';
  final _exception = Exception();
  final _createProvider = CreateAccountWithEmailAndPasswordProviderMock();
  final _createPresenter = CreateAccountWithEmailAndPasswordPresenter(
      provider: _createProvider, context: BuildContextMock());
  group('Create Account Email And Password Executor Test Presenter', () {
    test('Create Account Email And Password - Presenter - Success', () async {
      await _createPresenter.createAccount(_user, File('123456'));
      expect(_createProvider.callCreateAccountEmailAndPassword, 1);
    });

    test(
        'Create Account Email And Password - Create Success - Presenter - Failure',
        () async {
      _createPresenter.outCreateAccountController.listen((event) {
        if (event is ProcessingState) {
          expect(event, ProcessingState());
        }
        expect(event, _result);
      });
      _createPresenter.createdAccountReceiver(_result);
    });
    test(
        'Create Account Email And Password - Create Failed - Presenter - Failure',
        () async {
      _createPresenter.outCreateAccountController.listen((event) {
        expect(event, _exception);
      });
      _createPresenter.handleCreateAccountExceptionReceiver(_exception);
    });
  });
}
