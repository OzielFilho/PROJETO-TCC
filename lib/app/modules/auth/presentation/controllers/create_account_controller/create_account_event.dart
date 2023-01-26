import 'dart:io';

import '../../../../authentication/create_account_with_email_and_password/models/user_create_account_model.dart';

abstract class CreateAccountEvent {
  const CreateAccountEvent();
}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final UserCreateAccountModel userCreateAccountModel;
  final File? fileImage;

  CreateAccountWithEmailAndPasswordEvent(
      this.userCreateAccountModel, this.fileImage);
}

class CreateWithEmailAndPasswordEvent implements CreateAccountEvent {
  final String email;
  final String phone;
  final String name;
  final bool welcomePage;
  final List<String> contacts;
  final String password;
  final String? photo;
  final String confirmePassword;
  final File? fileImage;

  CreateWithEmailAndPasswordEvent({
    required this.fileImage,
    required this.email,
    required this.phone,
    required this.photo,
    required this.confirmePassword,
    required this.name,
    required this.contacts,
    required this.password,
    required this.welcomePage,
  });
}
