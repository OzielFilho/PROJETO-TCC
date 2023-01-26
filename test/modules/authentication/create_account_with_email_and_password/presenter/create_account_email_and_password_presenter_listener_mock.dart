import 'package:app/app/modules/authentication/create_account_with_email_and_password/presenter/create_account_with_email_and_password_presenter_listener.dart';

class CreateAccountWithEmailAndPasswordPresenterListenerMock
    implements CreateAccountWithEmailAndPasswordPresenterListener {
  int callsCreateAccountWithEmailAndPasswordReceiver = 0;
  int callsHandleCreateAccountWithEmailAndPasswordException = 0;

  @override
  void createdAccountReceiver(String result) {
    callsCreateAccountWithEmailAndPasswordReceiver += 1;
  }

  @override
  void handleCreateAccountExceptionReceiver(Exception exception) {
    callsHandleCreateAccountWithEmailAndPasswordException += 1;
  }
}
