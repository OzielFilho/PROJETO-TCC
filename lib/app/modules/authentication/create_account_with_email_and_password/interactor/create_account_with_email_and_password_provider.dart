import 'dart:io';

import '../models/user_create_account_model.dart';

abstract class CreateAccountWithEmailAndPasswordProvider {
  Future<void> createAccount(
      UserCreateAccountModel userCreateAccountModel, File? image);
}
