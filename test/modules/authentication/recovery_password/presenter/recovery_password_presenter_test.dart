import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/recovery_password/presenter/recovery_password_presenter.dart';
import 'package:test/test.dart';

import '../../../../mocks/build_context_mock.dart';
import '../interactor/recovery_password_provider_mock.dart';

void main() {
  final _exception = Exception();
  final _email = 'oziel@hotmail.com';
  final _recoveryPasswordProvider = RecoveryPasswordProviderMock();
  final _recoveryPasswordPresenter = RecoveryPasswordPresenter(
      context: BuildContextMock(), provider: _recoveryPasswordProvider);
  group('Recovery Password Executor Test Presenter', () {
    test('Recovery Password - Presenter - Success', () async {
      await _recoveryPasswordPresenter.recoveryPassword(_email);
      expect(_recoveryPasswordProvider.callRecoveryPassword, 1);
    });

    test('Recovery Password - Success - Presenter - Failure', () async {
      _recoveryPasswordPresenter.outRecoveryPasswordController.listen((event) {
        if (event is ProcessingState) {
          expect(event, ProcessingState());
        }
        expect(event, true);
      });
      _recoveryPasswordPresenter.recoveryPasswordReceiver(true);
    });
    test('Recovery Password -  Failed - Presenter - Failure', () async {
      _recoveryPasswordPresenter.outRecoveryPasswordController.listen((event) {
        expect(event, _exception);
      });
      _recoveryPasswordPresenter.handleRecoveryPasswordException(_exception);
    });
  });
}
