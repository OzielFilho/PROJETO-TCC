abstract class CreateAccountEvent {}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final String email;
  final String phone;
  final String name;
  final List<String> contacts;
  final String password;
  final String confirmePassword;

  CreateAccountWithEmailAndPasswordEvent(
      {required this.email,
      required this.phone,
      required this.confirmePassword,
      required this.name,
      required this.contacts,
      required this.password});
}
