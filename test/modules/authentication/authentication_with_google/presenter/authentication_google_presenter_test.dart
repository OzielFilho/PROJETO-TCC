import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/authentication/authentication_google/presenter/authentication_google_presenter.dart';
import 'package:test/test.dart';

import '../../../../mocks/build_context_mock.dart';
import '../interactor/authentication_google_provider_mock.dart';

main() {
  final _exception = Exception();
  final _authProvider = AuthenticationGoogleProviderMock();
  final _authPresenter = AuthenticationGooglePresenter(
      provider: _authProvider, context: BuildContextMock());
  final _result = 'success';

  group('Authentication With Google Executor Test Presenter', () {
    test('Authentication With Google - Presenter - Success', () async {
      await _authPresenter.authenticationGoogle();
      expect(_authProvider.callAuthenticationGoogle, 1);
    });

    test('Authentication With Google - Login Success - Presenter - Failure',
        () async {
      _authPresenter.outGoogleLoginController.listen((event) {
        if (event is ProcessingState) {
          expect(event, ProcessingState());
        }
        expect(event, _result);
      });
      _authPresenter.authenticationGoogleReceiver(_result);
    });
    test('Authentication With Google - Login Failed - Presenter - Failure',
        () async {
      _authPresenter.outGoogleLoginController.listen((event) {
        expect(event, _exception);
      });
      _authPresenter.handleAuthenticationGoogleException(_exception);
    });
  });
}
