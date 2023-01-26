import 'dart:io';

import '../models/user_create_account_model.dart';

abstract class CreateAccountWithEmailAndPasswordPresenterProvider {
  Stream<Object> get outCreateAccountController;
  Future<void> createAccount(
      UserCreateAccountModel userCreateAccountModel, File? image);
}
