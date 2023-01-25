import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/modules/authentication/modules/authentication_google/interactor/authentication_google_interactor_executor.dart';
import 'package:test/test.dart';

import '../../../../mocks/services/firebase_auth_service_mock_200.dart';
import '../../../../mocks/services/firebase_auth_service_mock_exception.dart';
import '../../../../mocks/services/firestore_service_mock_200.dart';
import '../../../../mocks/services/firestore_service_mock_exception.dart';
import '../presenter/authentication_google_presenter_listener_mock.dart';

main() {
  FirebaseAuthService _authService;

  final _credential = {'providerId': '132345', 'signInMethod': 'google'};
  final _authenticationListener = AuthenticationGooglePresenterListenerMock();

  group('Authentication With Google Executor Test', () {
    test('Authentication With Google - Interactor - Success', () async {
      _authService = FirebaseAuthServiceMock200(mock: 'success');
      final firestoreService = FirestoreServiceMock200(mock: 'success');

      final authenticationGoogle = AuthenticationGoogleInteractorExecutor(
          listener: _authenticationListener,
          authService: _authService,
          firestoreService: firestoreService);

      await authenticationGoogle.authenticationGoogle(_credential);

      expect(_authenticationListener.callsAuthenticationGoogleReceiver, 1);
    });

    test('Authentication With Google - Interactor - Failure', () async {
      _authService = FirebaseAuthServiceMockException();
      final firestoreService = FirestoreServiceMockException();
      final authenticationGoogle = AuthenticationGoogleInteractorExecutor(
          listener: _authenticationListener,
          authService: _authService,
          firestoreService: firestoreService);

      await authenticationGoogle.authenticationGoogle(_credential);

      expect(
          _authenticationListener.callsHandleAuthenticationGoogleException, 1);
    });
  });
}
