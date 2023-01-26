import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/models/authentication_params_model.dart';
import 'package:app/app/modules/authentication/authentication_email_and_password/presenter/authentication_email_and_password_presenter.dart';
import 'package:app/app/modules/authentication/enums/errors_enum_authentication.dart';
import 'package:test/test.dart';

import '../../../../mocks/build_context_mock.dart';
import '../interactor/authentication_email_and_password_provider_mock.dart';

main() {
  final _email = 'ozz@hotmail.com';
  final _password = '123456778';

  final _exception = Exception();
  final _authProvider = AuthenticationEmailAndPasswordProviderMock();
  final _authPresenter = AuthenticationEmailAndPasswordPresenter(
      provider: _authProvider, context: BuildContextMock());
  final _result = EnumAuthentication.emailNotVerified;

  group('Authentication With Email And Password Executor Test Presenter', () {
    test('Authentication With Email And Password - Presenter - Success',
        () async {
      await _authPresenter.authenticationEmailAndPassword(
          params: AuthenticationParamsModel(_email, _password));
      expect(_authProvider.callAuthenticationEmailAndPassword, 1);
    });

    test(
        'Authentication With Email And Password - Login Success - Presenter - Failure',
        () async {
      _authPresenter.outAuthController.listen((event) {
        if (event is ProcessingState) {
          expect(event, ProcessingState());
        }
        expect(event, _result);
      });
      _authPresenter.authenticationEmailAndPasswordReceiver(_result);
    });
    test(
        'Authentication With Email And Password - Login Failed - Presenter - Failure',
        () async {
      _authPresenter.outAuthController.listen((event) {
        expect(event, _exception);
      });
      _authPresenter.handleAuthenticationEmailAndPasswordException(_exception);
    });
  });
}
