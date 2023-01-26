import 'dart:io';

import 'package:app/app/modules/authentication/create_account_with_email_and_password/interactor/create_account_with_email_and_password_provider.dart';
import 'package:app/app/modules/authentication/create_account_with_email_and_password/models/user_create_account_model.dart';

class CreateAccountWithEmailAndPasswordProviderMock
    implements CreateAccountWithEmailAndPasswordProvider {
  int callCreateAccountEmailAndPassword = 0;

  @override
  Future<void> createAccount(
      UserCreateAccountModel userCreateAccountModel, File? image) async {
    callCreateAccountEmailAndPassword += 1;
  }
}
