import 'package:app/app/modules/authentication/authentication_google/presenter/authentication_google_presenter_listener.dart';

class AuthenticationGooglePresenterListenerMock
    implements AuthenticationGooglePresenterListener {
  int callsAuthenticationGoogleReceiver = 0;
  int callsHandleAuthenticationGoogleException = 0;

  @override
  void authenticationGoogleReceiver(String result) {
    callsAuthenticationGoogleReceiver += 1;
  }

  @override
  void handleAuthenticationGoogleException(Exception exception) {
    callsHandleAuthenticationGoogleException += 1;
  }
}
