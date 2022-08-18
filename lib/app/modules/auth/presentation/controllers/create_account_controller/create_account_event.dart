import 'dart:io';

abstract class CreateAccountEvent {}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final String email;
  final String phone;
  final String name;
  final bool welcomePage;
  final List<String> contacts;
  final String password;
  final File? photo;
  final String confirmePassword;

  CreateAccountWithEmailAndPasswordEvent({
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
