import 'package:app/app/modules/splash/interactor/refresh_token_interactor_provider.dart';

class RefreshTokenInteractorProviderMock
    implements RefreshTokenInteractorProvider {
  int callVerifyLoggedUser = 0;

  @override
  Future<void> verifyLoggedUser() async {
    callVerifyLoggedUser += 1;
  }
}
