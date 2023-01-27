import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:app/app/modules/splash/interactor/refresh_token_interactor_executor.dart';
import 'package:test/test.dart';

import '../../../../mocks/services/firebase_auth_service_mock_200.dart';
import '../../../../mocks/services/firebase_auth_service_mock_exception.dart';
import '../../../../mocks/services/firestore_service_mock_200.dart';
import '../../../../mocks/services/firestore_service_mock_exception.dart';
import '../../../../mocks/services/network_service_mock_200.dart';
import '../../../../mocks/services/network_service_mock_exception.dart';
import '../presenter/refresh_token_presenter_listener_mock.dart';

void main() {
  late FirebaseAuthService _authService;
  late FirestoreService _storeService;
  late final _listener = RefreshTokenPresenterListenerMock();
  group('Refresh Token Executor Test', () {
    test('Refresh Token - Interactor - Success', () async {
      _authService = FirebaseAuthServiceMock200(mock: 'success');
      _storeService = FirestoreServiceMock200(mock: 'success');
      final networkService = NetworkServiceMock200();

      final refreshToken = RefreshTokenInteractorExecutor(
          listener: _listener,
          authService: _authService,
          firestore: _storeService,
          networkService: networkService);

      await refreshToken.verifyLoggedUser();

      expect(_listener.callLoggedUserReceiver, 1);
    });

    test('Refresh Token - Interactor - Failure', () async {
      _authService = FirebaseAuthServiceMockException();
      _storeService = FirestoreServiceMockException();
      final networkService = NetworkServiceMockException();

      final refreshToken = RefreshTokenInteractorExecutor(
          listener: _listener,
          authService: _authService,
          firestore: _storeService,
          networkService: networkService);

      await refreshToken.verifyLoggedUser();

      expect(_listener.callHandleLoggedUserException, 1);
    });
  });
}
