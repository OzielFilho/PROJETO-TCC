abstract class LoginEvent {
  const LoginEvent();
}

class LoginWithEmailAndPasswordEvent implements LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordEvent(
      {required this.email, required this.password});
}
