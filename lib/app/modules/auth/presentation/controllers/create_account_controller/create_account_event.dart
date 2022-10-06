import 'dart:io';

import '../../../infra/models/user_create_account_model.dart';

abstract class CreateAccountEvent {
  const CreateAccountEvent();
}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final UserCreateAccountModel userCreateAccountModel;
  final File? fileImage;

  CreateAccountWithEmailAndPasswordEvent(
      this.userCreateAccountModel, this.fileImage);
}
