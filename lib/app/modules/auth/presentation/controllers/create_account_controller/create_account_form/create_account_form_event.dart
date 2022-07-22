import '../../../../domain/entities/user_create.dart';

class CreateAccountFormEvent extends UserCreate {
  final String email;
  final String password;
  final String confirmePassword;
  final String name;

  CreateAccountFormEvent(
      {required this.email,
      required this.password,
      required this.confirmePassword,
      required this.name});
}
