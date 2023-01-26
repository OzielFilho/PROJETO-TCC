import 'package:app/app/modules/authentication/create_account_with_email_and_password/interactor/create_account_with_email_and_password_receiver.dart';

class CreateAccountWithEmailAndPasswordReceiverMock
    implements CreateAccountWithEmailAndPasswordReceiver {
  int callCreateAccountEmailAndPasswordReceiver = 0;
  int callCreateAccountEmailAndPasswordException = 0;

  @override
  void createdAccountReceiver(String result) {
    callCreateAccountEmailAndPasswordReceiver += 1;
  }

  @override
  void handleCreateAccountExceptionReceiver(Exception exception) {
    callCreateAccountEmailAndPasswordException += 1;
  }
}
