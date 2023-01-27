import 'package:app/app/modules/splash/models/user_logged_info_model.dart';
import 'package:app/app/modules/splash/presenter/refresh_token_presenter.dart';
import 'package:test/test.dart';

import '../../../../mocks/build_context_mock.dart';
import '../interactor/refresh_token_interactor_provider_mock.dart';

void main() {
  final _result = UserLoggedInfoModel(
      logged: true, phone: '(85)988714868', welcomePage: false);
  final _exception = Exception();
  final _refreshProvider = RefreshTokenInteractorProviderMock();
  final _refreshPresenter = RefreshTokenPresenter(
      provider: _refreshProvider, context: BuildContextMock());
  group('Refresh Token Executor Test Presenter', () {
    test('Refresh Token - Presenter - Success', () async {
      await _refreshPresenter.verifyLoggedUser();
      expect(_refreshProvider.callVerifyLoggedUser, 1);
    });

    test('Refresh Token - Refresh Success - Presenter - Failure', () async {
      _refreshPresenter.outRefreshToken.listen((event) {
        expect(event, _result);
      });
      //_refreshPresenter.loggedUserReceiver(_result);
    });
    test('Refresh Token - Refresh Failed - Presenter - Failure', () async {
      _refreshPresenter.outRefreshToken.listen((event) {
        expect(event, _exception);
      });
      _refreshPresenter.handleLoggedUserException(_exception);
    });
  });
}
