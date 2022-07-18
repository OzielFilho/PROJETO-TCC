class Validations {
  static bool emailValidation({required String email}) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool passwordValidation({required String password}) {
    return password.length >= 6;
  }

  static bool emailAndPasswordValidation(
      {required String email, required String password}) {
    return (passwordValidation(password: password) ||
        emailValidation(email: email));
  }
}
