abstract class CreateAccountEvent {}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final String email;
  final String password;
  final String phone;

  CreateAccountWithEmailAndPasswordEvent(this.email, this.password, this.phone);
}
